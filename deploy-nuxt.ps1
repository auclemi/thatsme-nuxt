# Script de déploiement complet pour application Nuxt.js
# Gère le build local, le transfert et l'injection de .env.production

$ErrorActionPreference = "Stop"

# --- Configuration ---
$AppName = "thatsme-nuxt"
$SourceBuildFolder = ".output"
$DestRoot = "C:\Users\AUCLERMI\projects\thatsme-nuxt-prod"
$DestOutput = Join-Path $DestRoot ".output"
$EnvFileName = ".env.production"  # Mis à jour avec le bon nom de fichier
$LogFile = "deploy_log.txt"

function Write-Log {
    param([string]$Message)
    $TimeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $FullMessage = "[$TimeStamp] $Message"
    Write-Host $FullMessage -ForegroundColor Cyan
    Add-Content -Path $LogFile -Value $FullMessage
}

try {
    Write-Log "--- Début du processus de déploiement ---"

    # 1. Nettoyage du build local existant
    if (Test-Path $SourceBuildFolder) {
        Write-Log "Nettoyage du dossier de build local..."
        Remove-Item -Recurse -Force $SourceBuildFolder
    }

    # 2. Build de l'application Nuxt
    Write-Log "Lancement du build Nuxt (npm run build)..."
    npm run build

    # 3. Préparation du dossier de destination
    if (-not (Test-Path $DestRoot)) {
        Write-Log "Création du dossier racine de destination..."
        New-Item -ItemType Directory -Force -Path $DestRoot | Out-Null
    }

    # 4. Gestion du fichier d'environnement spécifique
    $SourceEnv = Join-Path "." $EnvFileName
    $DestEnv = Join-Path $DestRoot $EnvFileName

    if (Test-Path $SourceEnv) {
        Write-Log "Copie de $EnvFileName vers la destination..."
        Copy-Item -Path $SourceEnv -Destination $DestEnv -Force
    } else {
        Write-Log "ATTENTION : Fichier $EnvFileName introuvable à la racine du projet."
    }

    # 5. Gestion PM2 : On arrête/supprime l'ancien processus AVANT de toucher aux fichiers de production
    if (Get-Command pm2 -ErrorAction SilentlyContinue) {
        Write-Log "Arrêt et nettoyage du processus PM2..."
        
        # Récupération du JSON brut de PM2
        $rawJson = & pm2 jlist
        
        # On nettoie les doublons de variables Windows qui font planter PowerShell
        $cleanJson = $rawJson -replace '"username"\s*:\s*"[^"\\]*(?:\\.[^"\\]*)*"\s*,?', '' `
                             -replace '"USERNAME"\s*:\s*"[^"\\]*(?:\\.[^"\\]*)*"\s*,?', ''

        # Maintenant la conversion se fera sans erreur
        $pm2Status = $cleanJson | ConvertFrom-Json
        $processExists = $pm2Status | Where-Object { $_.name -eq $AppName }

        if ($processExists) {
            Write-Log "Ancien processus détecté. Suppression de $AppName..."
            & pm2 delete $AppName *>$null
        }
    }

    # 6. Vidage et déploiement du dossier .output (Sécurisé, aucun fichier n'est verrouillé ou utilisé)
    if (Test-Path $DestOutput) {
        Write-Log "Vidage du dossier .output de production..."
        Get-ChildItem -Path $DestOutput | Remove-Item -Recurse -Force
    } else {
        New-Item -ItemType Directory -Force -Path $DestOutput | Out-Null
    }

    Write-Log "Copie du build vers $DestOutput..."
    Copy-Item -Path "$SourceBuildFolder\*" -Destination $DestOutput -Recurse -Force

    # 7. Relance de PM2 avec les nouveaux fichiers
    if (Get-Command pm2 -ErrorAction SilentlyContinue) {
        Write-Log "Lancement de la nouvelle version avec PM2..."
        $ProdEntry = Join-Path $DestOutput "server/index.mjs"
        & pm2 start $ProdEntry --name $AppName --node-args="--env-file=$DestEnv"
        & pm2 save
        Write-Log "Application redémarrée avec PM2."
    } else {
        Write-Log "PM2 non détecté. Le déploiement est terminé."
    }

    Write-Log "--- Déploiement terminé avec succès ---"
}
catch {
    Write-Log "ERREUR LORS DU DÉPLOIEMENT : $($_.Exception.Message)"
    exit 1
}
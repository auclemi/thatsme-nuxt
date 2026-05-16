# Script de redémarrage pour application Nuxt.js

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
    Write-Log "--- Début du processus de redémarrage ---"

   
    # 1. Préparation du dossier de destination
    if (-not (Test-Path $DestRoot)) {
        Write-Log "Répertoire destination introuvable."
    }

    # 2. Gestion du fichier d'environnement spécifique
    $SourceEnv = Join-Path "." $EnvFileName
    $DestEnv = Join-Path $DestRoot $EnvFileName


  
    # 3. Gestion PM2 avec injection de l'environnement
    if (Get-Command pm2 -ErrorAction SilentlyContinue) {
        Write-Log "Mise à jour du processus PM2..."
        $ProdEntry = Join-Path $DestOutput "server/index.mjs"
        
        # On supprime l'ancien processus pour s'assurer que les nouveaux paramètres sont pris en compte
        & pm2 delete $AppName 2>$null
        
        # Lancement avec injection explicite du fichier .env.production
        & pm2 start $ProdEntry --name $AppName --node-args="--env-file=$DestEnv"
        
        & pm2 save
        Write-Log "Application redémarrée avec PM2."
    } else {
        Write-Log "PM2 non détecté. Le déploiement est terminé."
    }

    Write-Log "--- Redémarrage terminé avec succès ---"
}
catch {
    Write-Log "ERREUR LORS DU REDÉMARRAGE : $($_.Exception.Message)"
    exit 1
}
# Script de déploiement pour application Nuxt.js
# Ce script automatise l'installation, le build et le démarrage (ou la mise à jour) de l'application.

$ErrorActionPreference = "Stop"

# --- Configuration ---
$AppName = "thatsme-nuxt"
$BuildFolder = "..C:\Users\AUCLERMI\projects\thatsme-nuxt-prod\.output"
$LogFile = "deploy_log.txt"

function Write-Log {
    param([string]$Message)
    $TimeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $FullMessage = "[$TimeStamp] $Message"
    Write-Host $FullMessage -ForegroundColor Cyan
    Add-Content -Path $LogFile -Value $FullMessage
}

try {
    Write-Log "Début du déploiement de $AppName..."

    # 1. Vérification de Node.js
    if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
        throw "Node.js n'est pas installé sur cette machine."
    }

    # 2. Nettoyage des anciens builds (optionnel)
    if (Test-Path $BuildFolder) {
        Write-Log "Nettoyage de l'ancien dossier de build..."
        Remove-Item -Recurse -Force $BuildFolder
    }

    # 3. Installation des dépendances
    Write-Log "Installation des dépendances (npm install)..."
    npm install

    # 4. Build de l'application
    Write-Log "Génération du build (npm run build)..."
    npm run build

    # 5. Gestion du processus (Exemple avec PM2 si installé, sinon démarrage simple)
    if (Get-Command pm2 -ErrorAction SilentlyContinue) {
        Write-Log "Redémarrage de l'application avec PM2..."
        pm2 delete $AppName 2>$null
        pm2 start .output/server/index.mjs --name $AppName
        pm2 save
    } else {
        Write-Log "PM2 non trouvé. Lancement manuel via Node..."
        Write-Log "NOTE: Pour une production stable, il est recommandé d'utiliser PM2 ou un service Windows."
        # Note: Ceci est bloquant. Pour un script de CI/CD, utilisez un gestionnaire de processus.
        node .output/server/index.mjs
    }

    Write-Log "Déploiement terminé avec succès."
}
catch {
    Write-Log "ERREUR : $($_.Exception.Message)"
    exit 1
}

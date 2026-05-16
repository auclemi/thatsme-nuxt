<<<<<<< HEAD:skata.ps1
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
=======
# ===============================
#   BUILD & DEPLOY — THAT'S ME NUXT
# ===============================

Write-Host "=== BUILD BACKEND (BE) ==="
Write-Host "PM2 STOP..."
pm2 delete all
pm2 kill

# Dossiers DEV et PROD
$devPath  = "C:\Users\AUCLERMI\projects\thatsme-nuxt"
$prodPath = "C:\Users\AUCLERMI\projects\thatsme-nuxt-prod"

Write-Host "DEV folder  : $devPath"
Write-Host "PROD folder: $prodPath"

# 1) Nettoyage du dossier PROD
Write-Host "PROD API clean-up..."
if (Test-Path $prodPath\.output) {
    Remove-Item $prodPath\.output -Recurse -Force
}
if (Test-Path $prodPath\.nuxt) {
    Remove-Item $prodPath\.nuxt -Recurse -Force
}
if (Test-Path $prodPath\node_modules) {
    Remove-Item $prodPath\node_modules -Recurse -Force
}
#New-Item -ItemType Directory -Path $prodPath | Out-Null
# 2) Copie des fichiers DEV → PROD
Write-Host "Building on dev ..."
Set-Location $devPath
#$env:NODE_ENV="production"
npm run build

# 3) Copie des fichiers DEV → PROD
Write-Host "Copy backend to PROD..."
Copy-Item "$devPath\package.json"        "$prodPath\package.json"
Copy-Item "$devPath\package-lock.json"   "$prodPath\package-lock.json"
Copy-Item "$devPath\.output"                "$prodPath\.output" -Recurse -Force
Copy-Item "$devPath\.nuxt"                "$prodPath\.nuxt" -Recurse -Force
Copy-Item "$devPath\.env.production" "$prodPath\.env" -Force


# 4) Installation des dépendances en PROD
Write-Host "npm install..."
Set-Location $prodPath
npm install 

# 5) PM2 : relancer proprement
pm2 start .output\server\index.mjs --name thatsme-nuxt
pm2 save
# Retour au dossier initial
Set-Location $devPath
>>>>>>> favicons et deployment script:deploy-nuxt-copilot.ps1

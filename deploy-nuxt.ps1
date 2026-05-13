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

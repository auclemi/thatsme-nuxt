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
Write-Host "PROD clean-up..."
if (Test-Path $prodPath\) {
    Remove-Item $prodPath\ -Recurse -Force
}

#New-Item -ItemType Directory -Path $prodPath | Out-Null

# 2) Copie des fichiers DEV → PROD
Write-Host "Copy backend to PROD..."
Copy-Item "$devPath\package.json"        "$prodPath\package.json"
Copy-Item "$devPath\package-lock.json"   "$prodPath\package-lock.json"
Copy-Item "$devPath\.env.production" "$prodPath\.env" -Force
Copy-Item "$devPath\public" "$prodPath\public" -Recurse -Force
Copy-Item "$devPath\server" "$prodPath\server" -Recurse -Force
Copy-Item "$devPath\src" "$prodPath\src" -Recurse -Force


# 3) Installation des dépendances en PROD
Set-Location $prodPath
npm install
$env:NODE_ENV="production"
npm run build


# 4) PM2 : relancer proprement
pm2 start .output\server\index.mjs --name thatsme-nuxt
pm2 save
# Retour au dossier initial
Set-Location $devPath

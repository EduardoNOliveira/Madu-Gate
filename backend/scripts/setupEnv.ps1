param(
  [string]$OutputFile = ".env"
)

function Read-Secret([string]$Prompt) {
  $secure = Read-Host -Prompt $Prompt -AsSecureString
  $ptr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure)
  try {
    return [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($ptr)
  }
  finally {
    [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ptr)
  }
}

Write-Host "Configuracao do backend para Supabase" -ForegroundColor Cyan

$databaseUrl = Read-Host "DATABASE_URL (pooler Supabase)"
$adminName = Read-Host "ADMIN_NAME [Administrador]"
if ([string]::IsNullOrWhiteSpace($adminName)) { $adminName = "Administrador" }
$adminEmail = Read-Host "ADMIN_EMAIL"
$adminPassword = Read-Secret "ADMIN_PASSWORD"
$jwtSecret = Read-Secret "JWT_SECRET (deixe vazio para gerar automaticamente)"

if ([string]::IsNullOrWhiteSpace($databaseUrl)) {
  throw "DATABASE_URL e obrigatorio"
}
if ([string]::IsNullOrWhiteSpace($adminEmail)) {
  throw "ADMIN_EMAIL e obrigatorio"
}
if ([string]::IsNullOrWhiteSpace($adminPassword)) {
  throw "ADMIN_PASSWORD e obrigatorio"
}
if ([string]::IsNullOrWhiteSpace($jwtSecret)) {
  $jwtSecret = [Convert]::ToBase64String((1..48 | ForEach-Object { Get-Random -Maximum 256 }))
}

$content = @"
PORT=3000
DATABASE_URL=$databaseUrl
DB_SSL=true
JWT_SECRET=$jwtSecret
JWT_EXPIRES_IN=15m
REFRESH_TOKEN_EXPIRES_IN=7d
ADMIN_NAME=$adminName
ADMIN_EMAIL=$adminEmail
ADMIN_PASSWORD=$adminPassword
"@

Set-Content -Path $OutputFile -Value $content -Encoding UTF8
Write-Host "Arquivo $OutputFile criado com sucesso." -ForegroundColor Green

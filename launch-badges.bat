@echo off
chcp 65001 >nul
REM 🏆 GitHub Badges Mastery - Windows Launcher
REM Detecta e executa a versão apropriada

echo.
echo 🏆 GITHUB BADGES MASTERY - WINDOWS LAUNCHER
echo ==========================================
echo.

REM Verificar se PowerShell 7+ está disponível
pwsh -Command "Write-Host '✅ PowerShell 7+ encontrado'" 2>nul
if %errorlevel% equ 0 (
    echo 🚀 Executando com PowerShell 7...
    pwsh -File "EXECUTE-BADGES-UNIVERSAL.ps1" %*
    goto :end
)

REM Verificar se PowerShell 5.1 está disponível
powershell -Command "Write-Host '✅ PowerShell 5.1 encontrado'" 2>nul
if %errorlevel% equ 0 (
    echo ⚠️ Usando PowerShell 5.1 (recomenda-se PowerShell 7)
    echo 💡 Para melhor experiência, instale PowerShell 7: winget install Microsoft.PowerShell
    echo.
    powershell -File "EXECUTE-BADGES-UNIVERSAL.ps1" %*
    goto :end
)

REM PowerShell não encontrado
echo ❌ PowerShell não encontrado!
echo.
echo 💡 Soluções:
echo   1. Instale PowerShell 7: winget install Microsoft.PowerShell
echo   2. Ou execute manualmente: pwsh EXECUTE-BADGES-UNIVERSAL.ps1
echo   3. Ou use o script bash: bash launch-badges.sh
echo.
pause
exit /b 1

:end
echo.
echo 🎉 Launcher concluído!
if not "%1"=="--no-pause" pause
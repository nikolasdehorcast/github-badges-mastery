// 🧪 Testes para GitHub Badges Mastery
// Arquivo de testes para validar funcionalidades do projeto

const { 
    demonstrateBadges, 
    calculateProgress, 
    generateStatusReport, 
    simulateBadgeActivity 
} = require('../src/index.js');

/**
 * Teste para função demonstrateBadges
 */
function testDemonstrateBadges() {
    console.log('🧪 Testando função demonstrateBadges...');
    
    try {
        const badges = demonstrateBadges();
        
        // Verificar se retorna array
        if (!Array.isArray(badges)) {
            throw new Error('demonstrateBadges deve retornar um array');
        }
        
        // Verificar se tem 7 badges
        if (badges.length !== 7) {
            throw new Error(`Esperado 7 badges, recebido ${badges.length}`);
        }
        
        // Verificar estrutura de cada badge
        badges.forEach((badge, index) => {
            if (!badge.name || !badge.criteria || !badge.strategy || !badge.status) {
                throw new Error(`Badge ${index} está com estrutura incompleta`);
            }
        });
        
        console.log('✅ testDemonstrateBadges passou!');
        return true;
    } catch (error) {
        console.error('❌ testDemonstrateBadges falhou:', error.message);
        return false;
    }
}

/**
 * Teste para função calculateProgress
 */
function testCalculateProgress() {
    console.log('🧪 Testando função calculateProgress...');
    
    try {
        const progress = calculateProgress();
        
        // Verificar estrutura do retorno
        const requiredFields = ['total', 'inProgress', 'completed', 'pending', 'percentage'];
        requiredFields.forEach(field => {
            if (progress[field] === undefined) {
                throw new Error(`Campo ${field} não encontrado no progresso`);
            }
        });
        
        // Verificar se total é 7
        if (progress.total !== 7) {
            throw new Error(`Total esperado: 7, recebido: ${progress.total}`);
        }
        
        // Verificar se percentual está entre 0 e 100
        if (progress.percentage < 0 || progress.percentage > 100) {
            throw new Error(`Percentual inválido: ${progress.percentage}`);
        }
        
        console.log('✅ testCalculateProgress passou!');
        return true;
    } catch (error) {
        console.error('❌ testCalculateProgress falhou:', error.message);
        return false;
    }
}

/**
 * Teste para função generateStatusReport
 */
function testGenerateStatusReport() {
    console.log('🧪 Testando função generateStatusReport...');
    
    try {
        const report = generateStatusReport();
        
        // Verificar estrutura do relatório
        const requiredFields = ['timestamp', 'project', 'version', 'progress', 'nextSteps', 'recommendations'];
        requiredFields.forEach(field => {
            if (report[field] === undefined) {
                throw new Error(`Campo ${field} não encontrado no relatório`);
            }
        });
        
        // Verificar se timestamp é válido
        const timestamp = new Date(report.timestamp);
        if (isNaN(timestamp.getTime())) {
            throw new Error('Timestamp inválido no relatório');
        }
        
        // Verificar se nextSteps é array
        if (!Array.isArray(report.nextSteps)) {
            throw new Error('nextSteps deve ser um array');
        }
        
        // Verificar se recommendations é array
        if (!Array.isArray(report.recommendations)) {
            throw new Error('recommendations deve ser um array');
        }
        
        console.log('✅ testGenerateStatusReport passou!');
        return true;
    } catch (error) {
        console.error('❌ testGenerateStatusReport falhou:', error.message);
        return false;
    }
}

/**
 * Teste para função simulateBadgeActivity
 */
function testSimulateBadgeActivity() {
    console.log('🧪 Testando função simulateBadgeActivity...');
    
    try {
        // Capturar output do console
        const originalLog = console.log;
        let logOutput = '';
        console.log = (message) => {
            logOutput += message + '\n';
        };
        
        simulateBadgeActivity();
        
        // Restaurar console.log
        console.log = originalLog;
        
        // Verificar se contém palavras-chave esperadas
        const expectedKeywords = ['Pull Shark', 'DevOps Guru', 'Quickdraw', 'Simulação concluída'];
        expectedKeywords.forEach(keyword => {
            if (!logOutput.includes(keyword)) {
                throw new Error(`Palavra-chave "${keyword}" não encontrada na simulação`);
            }
        });
        
        console.log('✅ testSimulateBadgeActivity passou!');
        return true;
    } catch (error) {
        console.error('❌ testSimulateBadgeActivity falhou:', error.message);
        return false;
    }
}

/**
 * Teste de integração
 */
function testIntegration() {
    console.log('🧪 Testando integração completa...');
    
    try {
        // Executar todas as funções em sequência
        const badges = demonstrateBadges();
        const progress = calculateProgress();
        const report = generateStatusReport();
        
        // Verificar consistência entre funções
        if (badges.length !== progress.total) {
            throw new Error('Inconsistência entre número de badges e progresso total');
        }
        
        if (progress.total !== report.progress.total) {
            throw new Error('Inconsistência entre progresso e relatório');
        }
        
        console.log('✅ testIntegration passou!');
        return true;
    } catch (error) {
        console.error('❌ testIntegration falhou:', error.message);
        return false;
    }
}

/**
 * Função para executar todos os testes
 */
function runAllTests() {
    console.log('🚀 INICIANDO TESTES DO GITHUB BADGES MASTERY\n');
    console.log('='.repeat(50));
    
    const tests = [
        testDemonstrateBadges,
        testCalculateProgress,
        testGenerateStatusReport,
        testSimulateBadgeActivity,
        testIntegration
    ];
    
    let passed = 0;
    let failed = 0;
    
    tests.forEach((test, index) => {
        console.log(`\n📋 Teste ${index + 1}/${tests.length}:`);
        if (test()) {
            passed++;
        } else {
            failed++;
        }
    });
    
    console.log('\n' + '='.repeat(50));
    console.log('📊 RESUMO DOS TESTES:');
    console.log(`✅ Passou: ${passed}`);
    console.log(`❌ Falhou: ${failed}`);
    console.log(`📈 Taxa de sucesso: ${Math.round((passed / tests.length) * 100)}%`);
    
    if (failed === 0) {
        console.log('\n🎉 Todos os testes passaram! Projeto está funcionando corretamente.');
        return true;
    } else {
        console.log('\n⚠️ Alguns testes falharam. Verifique os erros acima.');
        return false;
    }
}

// Executar testes se for o arquivo principal
if (require.main === module) {
    const success = runAllTests();
    process.exit(success ? 0 : 1);
}

// Exportar funções de teste
module.exports = {
    testDemonstrateBadges,
    testCalculateProgress,
    testGenerateStatusReport,
    testSimulateBadgeActivity,
    testIntegration,
    runAllTests
};

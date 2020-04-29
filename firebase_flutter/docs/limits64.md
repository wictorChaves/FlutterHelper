# Evitar o limite de 64 K

## Resumo

Arquivos de app para Android (APK) contêm arquivos de bytecode executáveis no formato Dalvik Executable (DEX), que contêm o código compilado usado para executar o app. A especificação do executável Dalvik limita o total de métodos que podem ser referenciados em um único arquivo DEX a 65.536. Isso inclui métodos de framework do Android, métodos de biblioteca e métodos do seu próprio código. No contexto da ciência da computação, o termo Kilo, K, denota 1.024 (ou 2^10). Como 65.536 equivale a 64 X 1.024, esse limite é chamado de "limite de 64 K referências".

## Procedimento

Edite o arquivo `android\app\build.gradle`

Adicione:

    multiDexEnabled true
    
E também:

    implementation 'com.android.support:multidex:1.0.3'
    
Como no exemplo abaixo:

    android {
        defaultConfig {
            ...
            minSdkVersion 15
            targetSdkVersion 28
            multiDexEnabled true
        }
        ...
    }

    dependencies {
      implementation 'com.android.support:multidex:1.0.3'
    }
 
 ## Fonte
 
[Métodos para ativar multidex para apps com mais de 64 K](https://developer.android.com/studio/build/multidex#avoid)

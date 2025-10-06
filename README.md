# 🧮 Calculadora IMC 4

> Aplicativo Flutter moderno para cálculo e acompanhamento do Índice de Massa Corporal (IMC) com **persistência de dados local, gráfico histórico e tela de configurações personalizável**.

---

## 🌟 Destaques do Projeto

✅ **Cálculo automático do IMC** com base no peso e altura.  
✅ **Histórico completo** de medições com data, peso, altura e resultado.  
✅ **Mensagens de classificação** conforme o valor do IMC.  
✅ **Gráfico de evolução** dos resultados ao longo do tempo.  
✅ **Armazenamento local** utilizando Hive (rápido e leve).  
✅ **Tela de Configurações** para ajustar a altura personalizada.  
✅ **Persistência entre execuções** — o app lembra a altura e o histórico do usuário.  
✅ **Design moderno e responsivo**, com cores automáticas por classificação.  
✅ **Botão de limpar histórico** diretamente na AppBar.  
✅ **Faixa de debug removida** para visual mais limpo e profissional.  

---

## 🧠 Funcionalidades Principais

| Recurso | Descrição |
|----------|------------|
| 📏 **Cálculo IMC** | O usuário insere seu peso e o app calcula automaticamente o IMC com base na altura configurada. |
| 🗂️ **Histórico salvo** | Todos os cálculos são armazenados localmente via Hive e listados em ordem cronológica. |
| 🎨 **Classificação colorida** | Cada resultado exibe uma cor e mensagem de acordo com o nível de IMC. |
| ⚙️ **Configurações** | Permite definir uma altura personalizada e salvá-la para uso automático em novos cálculos. |
| 📈 **Gráfico IMC** | Mostra a evolução do IMC ao longo do tempo em um gráfico de linha suave. |
| 🧹 **Limpar histórico** | Um toque remove todos os registros anteriores. |

---

## 🧩 Estrutura do Projeto

imc4_app/
│
├── lib/
│ ├── main.dart
│ ├── models/
│ │ └── imc_model.dart
│ ├── screens/
│ │ ├── home_screen.dart
│ │ └── settings_screen.dart
│ └── imc_model.g.dart ← Gerado automaticamente pelo Hive
│
├── pubspec.yaml
└── README.md


---

## ⚙️ Instalação e Execução

### 1️⃣ Criar o projeto
```bash
flutter create imc4_app
cd imc4_app

2️⃣ Substituir os arquivos

Copie o conteúdo dos arquivos fornecidos (main.dart, imc_model.dart, etc.)
para dentro das respectivas pastas (lib/, models/, screens/).
3️⃣ Atualizar dependências

flutter pub get

4️⃣ Gerar os adaptadores Hive

flutter packages pub run build_runner build --delete-conflicting-outputs

5️⃣ Executar o aplicativo

flutter run

🧱 Tecnologias Utilizadas
Tecnologia	Função
🐝 Hive / hive_flutter	Armazenamento local rápido e eficiente.
🎨 fl_chart	Exibição de gráficos de evolução do IMC.
⚙️ path_provider	Acesso ao diretório local do app.
💚 Flutter / Dart	Framework base multiplataforma.
💡 Benefícios do App

    Simplicidade e eficiência — Interface limpa, intuitiva e moderna.

    Offline-ready — Funciona completamente sem internet.

    Persistência total — Mantém configurações e histórico entre aberturas.

    Visual dinâmico — Feedback visual com cores e gráficos.

    Código limpo e bem estruturado — Ideal para iniciantes entenderem Flutter + Hive.

🧑‍💻 Autor

Desenvolvido por: [João Camilo Tutuí 💻]
🚀 App de estudo e prática para domínio de Flutter e persistência local.

	
🏁 Conclusão

O IMC4 App é uma evolução do projeto anterior (IMC3), agora com:

    Persistência via Hive 🐝

    Histórico visual completo 🕓

    Gráfico interativo 📊

    Altura configurável ⚙️

Um excelente exemplo prático de como unir armazenamento local, UI moderna e Flutter limpo e escalável.
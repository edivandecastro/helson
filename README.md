# Helson Oauth2

>Máttugr Helson também é conhecido como filho de Helheim sendo eventualmente nomeado guardião da Ponte dos Amaldiçoados, garantindo que todas as entidades que cruzam a ponte estejam mortas. Aparentemente ele nasceu e foi criado em Hel. Crescer em uma tribo troll não pode ser uma vida fácil, mas crescer em Hel deve ser ainda pior. (God Of War)

## Objetivo do desenvolvimento da aplicação

Com o objetivo de compreender a fundo o funcionamento do protocolo OAuth2, e sem recorrer a bibliotecas que facilitem a criação de sistemas com essa tecnologia, como o Doorkeeper e o Omniauth, tomei a decisão de desenvolver uma aplicação que, fazendo uso de Service Objects e seguindo a arquitetura MVC do Rails, implementasse todo o fluxo do OAuth2 a partir do zero. Esse desafio permitiu-me adquirir um conhecimento completo e abrangente de todas as etapas do processo, desde a autenticação até a autorização, capacitando-me a compreender detalhadamente cada aspecto do OAuth2, de ponta a ponta.

O "Helson" é uma aplicação que atua como um provedor de autenticação e autorização com suporte ao protocolo OAuth2. O OAuth2 é um protocolo amplamente utilizado para permitir que aplicativos de terceiros autentiquem e obtenham permissão para acessar os recursos de um usuário sem a necessidade de compartilhar suas credenciais de login.

Como provedor OAuth2, o "Helson" desempenha as seguintes funções:

1. **Autenticação de Usuários:** O "Helson" autentica os usuários, verificando suas credenciais, como nome de usuário e senha.
2. **Emissão de Tokens de Acesso:** Após a autenticação bem-sucedida, o "Helson" emite tokens de acesso OAuth2 para os aplicativos de terceiros que desejam acessar os recursos dos usuários.
3. **Autorização de Aplicativos de Terceiros:** Os aplicativos de terceiros que desejam acessar os recursos dos usuários precisam ser registrados e autorizados pelo "Helson". Isso envolve a definição de escopos e permissões para os aplicativos, garantindo que os usuários concedam permissões específicas antes que os aplicativos possam acessar seus dados.
4. **Gerenciamento de Tokens e Sessões:** O "Helson" é responsável pelo gerenciamento de tokens de acesso e de atualização, garantindo que apenas aplicativos autorizados tenham acesso aos recursos dos usuários e que os tokens sejam válidos por um período determinado.
5. **Revogação de Autorizações:** Os usuários têm a capacidade de revogar as autorizações concedidas a aplicativos de terceiros por meio do "Helson". Isso proporciona aos usuários controle sobre seus dados e privacidade.
6. **Segurança Aprimorada:** A utilização do protocolo OAuth2 pelo "Helson" oferece uma camada adicional de segurança, pois os aplicativos de terceiros nunca têm acesso direto às credenciais de login dos usuários.

Em resumo, o "Helson" é uma aplicação que desempenha o papel de provedor OAuth2, permitindo que aplicativos de terceiros autentiquem e obtenham autorização para acessar os recursos dos usuários de forma segura e controlada, sem a necessidade de compartilhar senhas ou credenciais sensíveis. Isso é fundamental para proteger a privacidade e a segurança dos usuários enquanto permite a integração com outros serviços e aplicativos.

### Roles

- **Authorization Server:** Responsável pela autenticação e emissão de tokens de acesso (Access Token). Detém informações dos Resource Owner (Usuários) e expõe no formato de Claims através do Bearer Token. Autentica e interage com o usuário após identificar e autorizar o client (ex: Google).

- **Client:** É a aplicação que interage com o Resource Owner. Essa aplicação deve ser registrada no Authorization Server (Ex.: qualquer aplicação que queira usar a autenticação do Google).

- **Resource Owner:** É a pessoa (entidade) que concede o acesso aos seus dados. Literalmente o Dono do Recurso. É como o OAuth 2.0 classifica o usuário (Ex.: qualquer pessoa que tenha uma conta no Google).

- **Resource Server:** É um aplicativo que protege recursos por meio de tokens OAuth. Esses tokens são emitidos por um Authorization Server, normalmente para um aplicativo client. A tarefa do Resource Server é validar o token antes de servir um recurso ao client. Geralmente essa função é exercida por uma mesma aplicação que também faz o papel de Authorization Server (ex: Google).

### Database Design

**applications**

| Campo | Propósito |
| --- | --- |
| id | Chave primária que usa UUID |
| name | Nome do aplicativo cliente |
| client_id | Identificador único usado para identificar o cliente |
| client_secret | Usado juntamente com o client_id para autenticação do cliente |
| redirect_uri | Redireciona o resource owner para esta URI |
| scopes | Define quais os escopos do aplicativo cliente |
| user_id | Identificador da conta do resource owner |

**access_grants**

| Campo | Propósito |
| --- | --- |
| id | Chave primária que usa UUID |
| user_id | Identificador da conta do resource owner |
| application_id | Id da aplicação cliente que deve ser emitido o acesso |
| token | Token de acesso |
| expires_in | TTL (Time To Live) do token em segundos |
| redirect_uri | Redireciona o resource owner para esta URI |
| revoked_at | Dia e hora de quando o token foi revogado |
| created_at | data e hora do registro de acesso |
| scopes | Escopo de acesso do token |

**access_tokens**

| Campo | Propósito |
| --- | --- |
| id | Chave primária que usa UUID |
| user_id | Identificador da conta do resource owner |
| application_id | Id da aplicação cliente que deve ser emitido o token |
| token | Token de acesso |
| refresh_token | token de atualização (usado para atualizar o token) |
| expires_in | TTL (Time To Live) do token em segundos |
| revoked_at | Dia e hora de quando o token foi revogado |
| created_at | data e hora do registro de acesso |
| scopes | Escopo de acesso do token |

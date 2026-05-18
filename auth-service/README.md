# Tech Challenge 3 - auth-service

Microsserviço de autenticação desenvolvido em Go para o Tech Challenge 3.

O serviço é responsável por:

- geração de API Keys
- validação de chaves
- autenticação entre microsserviços
- healthcheck para Kubernetes
- integração com PostgreSQL
- integração com pipeline DevSecOps

---

# Estrutura

```text
repo/
├── .github/
│   └── workflows/
│       └── auth-service-pipeline.yaml
├── auth-service/
│   ├── db/
│   │   └── init.sql
│   ├── .dockerignore
│   ├── Dockerfile
│   ├── README.md
│   ├── go.mod
│   ├── go.sum
│   ├── handlers.go
│   ├── key.go
│   ├── main.go
│   └── main_test.go
```

---

# Variáveis de ambiente

A aplicação utiliza as seguintes variáveis em runtime:

```env
DATABASE_URL=postgres://<user>:<password>@<host>:5432/auth_db
PORT=8001
MASTER_KEY=<your-master-key>
```

## Kubernetes / GitOps

Em ambientes Kubernetes/EKS, recomenda-se configurar:

- `DATABASE_URL` via Secret
- `MASTER_KEY` via Secret
- `PORT` via ConfigMap

---

# Endpoints

| Método | Endpoint | Descrição |
|---|---|---|
| GET | `/health` | Healthcheck da aplicação |
| GET | `/validate` | Validação de API Key |
| POST | `/admin/keys` | Criação de novas chaves |

---

# Pipeline CI/CD

O workflow:

```text
.github/workflows/auth-service-pipeline.yaml
```

executa:

1. Build da aplicação
2. Testes unitários
3. Lint com `gofmt`
4. Análise estática com `go vet`
5. SCA (Software Composition Analysis) com Trivy
6. SAST (Static Application Security Testing) com gosec
7. Build da imagem Docker
8. Container image scan com Trivy
9. Push da imagem para Amazon ECR

---

# Secrets necessários no GitHub

Configure os seguintes secrets no repositório GitHub:

```text
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_SESSION_TOKEN
```

## Observação

Em ambientes AWS Academy/Learner Lab, o `AWS_SESSION_TOKEN` é obrigatório e expira periodicamente.

---

# Amazon ECR

O pipeline publica a imagem Docker no Amazon ECR utilizando tags baseadas no commit SHA:

```text
auth-service:${GITHUB_SHA}
```

Certifique-se de que o repositório ECR exista previamente.

Exemplo:

```text
auth-service
```

O nome deve ser compatível com o configurado:
- no workflow
- no Terraform
- nos manifests Kubernetes

---

# Kubernetes

O serviço foi preparado para execução em Kubernetes/EKS com:

- Deployment
- Service
- Ingress
- Secret
- ConfigMap
- Healthcheck

---

# Tecnologias utilizadas

- Go
- PostgreSQL
- Docker
- Kubernetes
- Amazon EKS
- Amazon ECR
- GitHub Actions
- Trivy
- gosec

---

# Segurança

O serviço implementa:

- autenticação por API Key
- armazenamento seguro de hashes
- análise SAST
- análise SCA
- container scanning
- validação de dependências

# CITech03 - auth-service

Pipeline e serviço de autenticação em Go para o Tech Challenge 3.

Este pacote segue o padrão do `analytics-service`, mas usando o código real do `auth-service` do Tech Challenge 2.

## Estrutura

```text
CITech03-auth/
├── .github/workflows/
│   └── CIteste.yaml
├── db/
│   └── init.sql
├── .dockerignore
├── Dockerfile
├── go.mod
├── go.sum
├── handlers.go
├── key.go
├── main.go
├── main_test.go
└── README.md
```

## Variáveis de ambiente da aplicação

A aplicação precisa destas variáveis em runtime:

```env
DATABASE_URL=postgres://usuario:senha@host:5432/auth_db
PORT=8001
MASTER_KEY=admin-secreto-123
```

No Kubernetes/GitOps, configure esses valores por `Secret`/`ConfigMap`.

## Endpoints principais

- `GET /health`
- `GET /validate`
- `POST /admin/keys`

## Pipeline

O workflow `.github/workflows/CIteste.yaml` executa:

1. Build e testes unitários
2. Lint com `gofmt` e `go vet`
3. SCA com Trivy filesystem scan
4. SAST com gosec
5. Docker build
6. Container scan com Trivy
7. Push da imagem para Amazon ECR

## Secrets necessários no GitHub

Configure no repositório:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_SESSION_TOKEN` se estiver usando AWS Academy

## ECR

O pipeline publica a imagem no ECR com o nome:

```text
auth-service:${GITHUB_SHA}
```

Garanta que o repositório ECR `auth-service` exista, ou ajuste `SERVICE_NAME` no workflow para o nome correto criado pelo Terraform.

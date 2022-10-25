# Oficina de Projetos - Grupo 01

## Explicações

A princípio este código está gerando um grupo de autoscaling sem nenhuma instância.
Uma instância separada é criada instalando o glpi e suas dependências, depois disso uma imagem deve ser criada a partir dessa instância e adicionada na configuração de autoscaling.

## Passos necessários

1. Instalar AWS CLI e configurar as credenciais
2. Instalar o Terraform
3. Definir a região no arquivo variables.tf

## Comandos do Terraform

Inicializar
```bash
terraform init
```

Verificar os recursos que serão criados
```bash
terraform plan
```

Aplicar as configurações
```bash
terraform apply
```

Destruir o ambiente
```bash
terraform destroy
```

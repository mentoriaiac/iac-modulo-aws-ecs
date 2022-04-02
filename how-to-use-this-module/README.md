# Template de módulo Terraform

## Dependências

Para realizar os testes localmente é necessário:

| Ferramentas | Versão | Instalação |
| ----------- | ------ | ---------- |
| Terraform   | >= 1.0.0 | [Acesse](https://learn.hashicorp.com/tutorials/terraform/install-cli) |
| Git |  >= 2.30.2 | [Acesse](https://git-scm.com/downloads) |

# Utilizando o módulo

### Primeiro Passo:

Acesse o repósitorio do módulo :

<pre>

├── product-api-go
│   ├── blueprint
│   ├── client
│   ├── config
│   ├── data
│   │   └── model
│   ├── database
│   ├── docker_compose
│   ├── functional_tests
│   │   └── features
│   ├── handlers
│   └── telemetry
<b>└── template-modulo-terraform </b>
    └── how-to-use-this-module

</pre>

Depois acesse a pasta how-to-use-this-module

```

cd ./how-to-use-this-module/

```

Inicialize o Terraform

```

terraform init

```

### Segundo Passo:

Personalize o `terrafile.tf`:

```
 order = {
    Terraspresso = 4,
    Nomadicano = 10,
    "Vagrante espresso" = 4,
    Packer Spiced Latte = 6,
    Vaulatte = 8,
    Connectaccino = 2
    }  

```

Tente criar o primeiro plan:
```

terraform plan

```

Obs.: Caso retorne erro 401, verifique o usuário e a senha.

### Terceiro Passo:

Aplique suas mudanças:

```

terraform apply

```
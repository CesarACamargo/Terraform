resource "aws_ecr_repository" "ecr_repo" {
  name                 = "bia"
  image_tag_mutability = "MUTABLE"

  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }
}

/*
## Apos criar o repositorio verificar se tem permissão para subir a imagem, caso contrario executar os comandos abaixo num script.sh

#!/bin/bash

ECR_REGISTRY="SEU_REGISTRY_DO_REPOSITORIO"
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_REGISTRY
docker build -t bia .
docker tag bia:latest $ECR_REGISTRY/bia:latest
docker push $ECR_REGISTRY/bia:latest

*/

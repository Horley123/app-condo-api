#!/bin/zsh

MODULE_NAME=$1

if [ -z "$MODULE_NAME" ]; then
  echo "Uso: ./setup.sh nome-do-modulo"
  exit 1
fi

# Converte para PascalCase manualmente
CAPITALIZED_MODULE_NAME="$(echo $MODULE_NAME | sed -E 's/(^|_)([a-z])/\U\2/g')"

BASE_PATH="src/modules/$MODULE_NAME"

mkdir -p $BASE_PATH/controller
mkdir -p $BASE_PATH/services
mkdir -p $BASE_PATH/entity
mkdir -p $BASE_PATH/repository
mkdir -p $BASE_PATH/interface

# Controller
cat <<EOF > $BASE_PATH/controller/${MODULE_NAME}.controller.ts
import { Controller } from '@nestjs/common';

@Controller('$MODULE_NAME')
export class ${CAPITALIZED_MODULE_NAME}Controller {}
EOF

# Service
cat <<EOF > $BASE_PATH/services/${MODULE_NAME}.service.ts
import { Injectable } from '@nestjs/common';

@Injectable()
export class ${CAPITALIZED_MODULE_NAME}Service {}
EOF

# Entity
cat <<EOF > $BASE_PATH/entity/${MODULE_NAME}.entity.ts
import { Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class ${CAPITALIZED_MODULE_NAME}Entity {
  @PrimaryGeneratedColumn()
  id: number;
}
EOF

# Repository
cat <<EOF > $BASE_PATH/repository/${MODULE_NAME}.repository.ts
export class ${CAPITALIZED_MODULE_NAME}Repository {}
EOF

# Interface
cat <<EOF > $BASE_PATH/interface/${MODULE_NAME}.interface.ts
export interface I${CAPITALIZED_MODULE_NAME} {}
EOF

# Index files
echo "export * from './${MODULE_NAME}.controller';" > $BASE_PATH/controller/index.ts
echo "export * from './${MODULE_NAME}.service';" > $BASE_PATH/services/index.ts
echo "export * from './${MODULE_NAME}.entity';" > $BASE_PATH/entity/index.ts
echo "export * from './${MODULE_NAME}.repository';" > $BASE_PATH/repository/index.ts
echo "export * from './${MODULE_NAME}.interface';" > $BASE_PATH/interface/index.ts

echo "Módulo '$MODULE_NAME' criado com sucesso!"

#!/bin/bash

echo -e "Iniciando a instalação..."

sleep 2
# 1. Verificar se o usuário é root (sudo)


# 2. Atualizar repositórios
echo -e "Atualizando pacotes do sistema..."
zypper update && zypper upgrade -y

sleep 2

# 3. Instalar dependências (Exemplo: Git e Curl)
echo -e "Instalando wget..."
zypper install -y wget gzip

sleep 2

# 4. Baixando Minecraft
echo -e "Baixando arquivos necessários...  "
mkdir /opt/minecraft-launcher
cd /opt/minecraft-launcher
wget -P /opt/minecraft-launcher https://launcher.mojang.com/download/Minecraft.tar.gz 

sleep 2

# .5 Descompactar arquivos
echo -e "Descompactando arquivos...  " 
tar -xvzf Minecraft.tar.gz 
sleep 2

# 6. Mover arquivos para os diretórios apropriados
echo -e "Movendo blocos para /usr/bin...  "
cd minecraft-launcher
sudo mv minecraft-launcher /usr/bin/ # mv minecraft-launcher /usr/bin/minecraft-launcher

sleep 2

# 5. Simular o download de um arquivo
# curl -L https://link-do-seu-app.com/binario -o /opt/meu_projeto/app

# 6. Finalização
echo -e "-----------------------------------------"
echo -e "Instalação concluída com sucesso!"
echo -e "Obrigado por utilizar o script de automação."
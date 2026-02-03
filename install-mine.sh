#!/bin/bash


# Cores para facilitar a leitura
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'


echo -e "${GREEN}Iniciando a instalação do Minecraft...${NC}"


# 1. Verificar se o usuário é root
if [ "$EUID" -ne 0 ]; then 
  echo -e "${RED}Erro: Por favor, execute como root (use sudo).${NC}"
  exit 1
fi


# 2. Atualizar repositórios e instalar dependências
echo -e "Atualizando pacotes e instalando wget/gzip..."
zypper update -y
zypper install -y wget gzip
sleep 2


# 3. Limpar instalações antigas e preparar diretório
echo -e "Limpando diretórios antigos..."
rm -rf /opt/minecraft-launcher
rm -f /usr/bin/minecraft-launcher
mkdir -p /opt/minecraft-launcher


# 4. Baixando Minecraft
echo -e "Baixando o launcher oficial"
cd /tmp
git clone https://github.com/nek-ros/Minecraft-Installer-for-Opensuse.git
sleep 2 
mv /tmp/Minecraft-Installer-for-Opensuse/src/launcher.png /opt/minecraft-launcher/
sleep 2
wget https://launcher.mojang.com/download/Minecraft.tar.gz
sleep 2


# 5. Descompactar
echo -e "Descompactando arquivos..."
tar -xvzf Minecraft.tar.gz
# Move o conteúdo de dentro da pasta extraída para /opt/minecraft-launcher
mv minecraft-launcher/* /opt/minecraft-launcher/


# 6. Criar o link simbólico (Executável)
# Isso faz com que o comando 'minecraft-launcher' funcione no terminal
ln -sf /opt/minecraft-launcher/minecraft-launcher /usr/bin/minecraft-launcher


# 7. Criar o arquivo .desktop (O seu erro de ícone estava aqui)
echo -e "Criando atalho no menu de aplicativos..."
cat <<EOF > /usr/share/applications/Minecraft.desktop
[Desktop Entry]
Name=Minecraft
Comment=Launcher Unoficial do Minecraft
GenericName=Game
Exec=/usr/bin/minecraft-launcher
Icon=/opt/minecraft-launcher/launcher.png
Terminal=false
Type=Application
Categories=Game;Simulation;
Keywords=mojang;minecraft;launcher;
StartupNotify=true
EOF


# 8. Ajustar permissões (Essencial para o GNOME mostrar o ícone)
chmod +x /usr/share/applications/Minecraft.desktop
chmod +x /usr/bin/minecraft-launcher


# 9. Atualizar base de dados de aplicativos
update-desktop-database /usr/share/applications/


echo -e "${GREEN}-----------------------------------------${NC}"
echo -e "${GREEN}Instalação concluída com sucesso!${NC}"
echo -e "O ícone deve aparecer no seu menu agora."
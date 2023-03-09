# Instalação do PYENV
echo 'Instalando o pyenv...'
cd /tmp
export PYENV_GIT_TAG=v2.3.8
curl https://pyenv.run | bash
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo >> ~/.bashrc
source ~/.bashrc
pyenv update

# Instalação do python
LATEST_PYTHON=$(pyenv install --list | grep -E "3.[^/][^/].[^/]" | grep -v miniconda | grep -v pypy | grep -v anaconda | grep -v miniforge | grep -v nogil | grep -v dev | grep -v 0a3 | tail -1)
HIGHER_VERSION=$(echo $LATEST_PYTHON | cut -d"." -f2)
VERSION=$(($HIGHER_VERSION - 3))

while ((VERSION <= HIGHER_VERSION)); do
    pyenv install "3.$VERSION:latest"
    pyenv install "3.$VERSION-dev"
    let VERSION++
done

pyenv install anaconda3-2022:latest
pyenv global $LATEST_PYTHON
unset LATEST_PYTHON HIGHER_VERSION VERSION

# Configurações
pyenv exec pip install --upgrade pip
pip install pipx
exec bash
pipx install poetry
exec bash
poetry config virtualenvs.in-project true

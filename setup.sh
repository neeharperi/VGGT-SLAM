#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# 0. Clean Prior Installations
echo "Cleaning prior installations..."
rm -rf salad
rm -rf vggt
rm -rf sam2

# 1. Install Python dependencies
echo "Installing base requirements..."
pip install torch==2.5.1 torchvision==0.20.1 torchaudio==2.5.1 --index-url https://download.pytorch.org/whl/cu121
pip install -r requirements.txt

# 2. Clone and install Salad
echo "Cloning and installing Salad..."
git clone https://github.com/Dominic101/salad.git
pip install -e ./salad

# 3. Clone and install RAFT, RAFT is not used for optical flow by default
# echo "Cloning and installing RAFT..."
# git clone https://github.com/<omitted>/RAFT.git
# pip install -e ./RAFT
# cd RAFT
# echo "Downloading RAFT models..."
# ./download_models.sh
# cd ..

# 4. Clone and install VGGT
echo "Cloning and installing VGGT..."
git clone https://github.com/facebookresearch/vggt.git
pip install -e ./vggt

# 5. Install current repo in editable mode
echo "Installing current repo..."
pip install -e .

# 6. Clone and install external dependencies
echo "Cloning and installing SAM2..."
git clone https://github.com/facebookresearch/sam2.git
pip install -e ./sam2

cd ./sam2/checkpoints && \
./download_ckpts.sh && \
cd ../..

pip install git+https://github.com/microsoft/MoGe.git

#echo "Cloning and installing MapAnything..."
#git clone https://github.com/facebookresearch/map-anything.git
#pip install -e ./map-anything

echo "Installation Complete"

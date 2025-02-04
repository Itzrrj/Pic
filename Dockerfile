# Use official Python base image
FROM python:3.8-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    python3-dev \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install required Python packages
RUN pip install torch torchvision torchaudio \
    matplotlib \
    numpy \
    opencv-python-headless

# Clone GFPGAN repository
RUN git clone https://github.com/TencentARC/GFPGAN.git

# Set the working directory
WORKDIR /GFPGAN

# Install dependencies
RUN pip install -r requirements.txt

# Download pre-trained GFPGAN model
RUN wget https://github.com/TencentARC/GFPGAN/releases/download/v1.0.0/gfpgan.pth -P ./experiments/pretrained_models

# Expose port (optional)
EXPOSE 5000

# Command to run GFPGAN for image enhancement
CMD ["python", "inference_gfpgan.py", "--input", "input.jpg", "--output", "output.jpg", "--model_path", "experiments/pretrained_models/gfpgan.pth"]

# Base image
FROM python:3.11.11

# Install necessary system tools and libraries
RUN apt-get update && apt-get install -y \
    libopencv-dev \
    libv4l-dev \
    v4l-utils \
    ffmpeg \
    v4l2loopback-dkms \
    && apt-get clean

# Ensure ffmpeg/v4l2loopback is set up
RUN modprobe v4l2loopback

# Set the working directory
WORKDIR /app

# Copy your application files
COPY . .

# Install Python dependencies
RUN pip install -r requirements.txt

# Start command
CMD ["python", "app.py"]

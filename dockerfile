# Use an appropriate base image (e.g., Python 3.10 slim)
FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libopencv-dev \
    libv4l-dev \
    v4l-utils \
    ffmpeg \
    v4l2loopback-dkms \
    && apt-get clean

# Load the v4l2loopback kernel module to simulate a camera device
RUN modprobe v4l2loopback

# Set working directory to /app (adjust as needed)
WORKDIR /app

# Copy the app code into the container
COPY . .

# Install Python dependencies (assuming you have a requirements.txt)
RUN pip install -r requirements.txt

# Expose any necessary ports (if your app listens on specific ports)
EXPOSE 5000

# The start command: Run ffmpeg in the background to simulate a camera and then start the Python app
CMD ffmpeg -re -stream_loop -1 -i input_video.mp4 -f v4l2 /dev/video0 & python app.py

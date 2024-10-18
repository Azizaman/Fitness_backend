# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies required for MediaPipe
RUN apt-get update && apt-get install -y \
    libopencv-dev \
    ffmpeg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy the requirements.txt file into the container
COPY requirements.txt .

# Upgrade pip and install dependencies
RUN pip install --upgrade pip

# Install MediaPipe first (ensure to get latest version that matches your setup)
RUN pip install mediapipe==0.10.0

# Install other dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the port on which your app runs
EXPOSE 8000

# Specify the command to run your backend (adjust as per your app's entry point)
CMD ["python", "app.py", "runserver", "0.0.0.0:8000"]

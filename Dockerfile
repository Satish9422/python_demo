# Stage 1: Build environment
FROM python:3.9 AS builder

# Set working directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy the rest of the application code
COPY . .

# Stage 2: Runtime environment
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy only necessary files from the previous stage
COPY --from=builder /app .

# Expose the port your app runs on
EXPOSE 5000

# Command to run the application
CMD ["python", "app.py"]

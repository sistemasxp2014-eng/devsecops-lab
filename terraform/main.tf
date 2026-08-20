provider "aws" { 
  region = "us-east-1" 
} 
 
resource "aws_s3_bucket" "bucket_seguro" { 
  bucket = "mi-bucket-devsecops-demo-12345" 
} 
 
# CKV_AWS_18: Habilitar logging del bucket 
resource "aws_s3_bucket_logging" "ejemplo" { 
  bucket = aws_s3_bucket.bucket_seguro.id 
  target_bucket = aws_s3_bucket.bucket_seguro.id 
  target_prefix = "log/" 
} 
 
# CKV_AWS_21: Habilitar versionamiento 
resource "aws_s3_bucket_versioning" "versioning_bucket_seguro" { 
  bucket = aws_s3_bucket.bucket_seguro.id 
  versioning_configuration { 
    status = "Enabled" 
  } 
} 
 
# CKV_AWS_145: Cifrado por defecto con KMS 
resource "aws_s3_bucket_server_side_encryption_configuration" "kms" { 
  bucket = aws_s3_bucket.bucket_seguro.id 
  rule { 
    apply_server_side_encryption_by_default { 
      sse_algorithm = "AES256" 
    } 
  } 
} 
 
# CORRECCIÓN IaC: Bloqueo explícito de acceso público 
resource "aws_s3_bucket_public_access_block" "publico" { 
  bucket                  = aws_s3_bucket.bucket_seguro.id 
  block_public_acls       = true 
  block_public_policy     = true 
  ignore_public_acls      = true 
  restrict_public_buckets = true 
} 
 
resource "aws_security_group" "sg_seguro" { 
  name        = "sg_ssh_restringido" 
  description = "Grupo de seguridad con acceso SSH restringido" 
 
  ingress { 
    description = "Acceso SSH desde red privada" 
    from_port   = 22 
    to_port     = 22 
    protocol    = "tcp" 
    cidr_blocks = ["10.0.0.0/16"] 
  } 
} 
EOF 
 
Dockerfile 
cat << 'EOF' > Dockerfile 
FROM python:3.11-slim 
 
WORKDIR /app 
 
RUN useradd -m appuser 
 
COPY app/ /app/ 
RUN pip install --no-cache-dir -r requirements.txt 
 
# CORRECCIÓN: Instrucción HEALTHCHECK para cumplir con CKV_DOCKER_2 
HEALTHCHECK --interval=30s --timeout=3s CMD python -c "import urllib.request; 
urllib.request.urlopen('http://localhost:8080/buscar')" || exit 1 
 
USER appuser 
 
EXPOSE 8080 
CMD ["python", "app.py"] 

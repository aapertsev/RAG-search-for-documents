FROM python:3.13-slim

COPY README.md /app/README.md

# Команда по умолчанию: вывести приветствие и выйти
CMD ["python", "-c", "print('Docker CI is ready')"]

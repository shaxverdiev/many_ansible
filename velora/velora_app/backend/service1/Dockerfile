# Этап 1: Сборка
FROM golang:alpine AS builder

# Установка зависимостей для сборки
RUN apk add --no-cache git

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем go.mod и go.sum, чтобы установить зависимости
COPY go.mod ./

# Устанавливаем зависимости
RUN go mod download

# Копируем исходный код приложения
COPY . .

# Собираем приложение
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o myapp .



# Этап 2: Минимальный образ для выполнения
FROM alpine:latest

# Установка сертификатов для HTTPS запросов (если нужно)
RUN apk --no-cache add ca-certificates

# Копируем собранный бинарный файл из этапа 1
COPY --from=builder /app/myapp /usr/local/bin/myapp

# Устанавливаем рабочую директорию
WORKDIR /root/

# Определяем команду для запуска приложения
CMD ["myapp"]

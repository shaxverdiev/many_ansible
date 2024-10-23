# Этап 1: Сборка
FROM node:alpine AS builder

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json для установки зависимостей
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем все файлы проекта
COPY . .

# Собираем приложение
RUN npm run build



# Этап 2: Минимальный образ для развертывания
FROM nginx:alpine

# Удаляем дефолтный конфиг Nginx и заменяем на наш собственный, если нужно
COPY app.conf /etc/nginx/conf.d/default.conf

# Копируем собранные файлы из первого этапа
COPY --from=builder /app/dist /etc/nginx/dist

# Экспонируем порт
EXPOSE 80

# Запуск Nginx
CMD ["nginx", "-g", "daemon off;"]

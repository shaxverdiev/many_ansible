<template>
  <div class="container">
    <h1>Информация о сервере</h1>
    <p><strong>Имя хоста:</strong> {{ data.hostname }}</p>
    <p><strong>Текущее время:</strong> {{ formattedTime }}</p>
    <p><strong>Случайное число:</strong> {{ data.random_number }}</p>
  </div>
</template>

<script>
export default {
  data() {
    return {
      data: {},
    };
  },
  computed: {
    // Форматирование времени в ЧЧ:ММ:СС
    formattedTime() {
      if (this.data.current_time) {
        const date = new Date(this.data.current_time);
        const hours = String(date.getHours()).padStart(2, '0');
        const minutes = String(date.getMinutes()).padStart(2, '0');
        const seconds = String(date.getSeconds()).padStart(2, '0');
        return `${hours}:${minutes}:${seconds}`;
      }
      return '';
    },
  },
  mounted() {
    // Загружаем данные при загрузке страницы
    fetch('http://127.0.0.1:8081/')
      .then(response => response.json())
      .then(json => {
        this.data = json;
      })
      .catch(error => {
        console.error('Ошибка при получении данных:', error);
      });
  },
};
</script>

<style scoped>
.container {
  max-width: 600px;
  margin: 50px auto;
  padding: 20px;
  background-color: #f0f0f0;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
h1 {
  text-align: center;
  margin-bottom: 20px;
}
p {
  font-size: 18px;
  line-height: 1.5;
}
</style>

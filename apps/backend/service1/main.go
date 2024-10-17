package main

import (
    "encoding/json"
    "fmt"
    "log"
    "math/rand"
    "net/http"
    "os"
    "time"
)

type Response struct {
    Hostname     string `json:"hostname"`
    CurrentTime  string `json:"current_time"`
    RandomNumber int    `json:"random_number"`
}

func handler(w http.ResponseWriter, r *http.Request) {
    // Установим CORS-заголовки
    w.Header().Set("Access-Control-Allow-Origin", "*")
    w.Header().Set("Access-Control-Allow-Methods", "GET, OPTIONS")
    w.Header().Set("Access-Control-Allow-Headers", "Content-Type")

    // Обработка preflight-запроса OPTIONS
    if r.Method == http.MethodOptions {
        w.WriteHeader(http.StatusOK)
        return
    }

    hostname, err := os.Hostname()
    if err != nil {
        http.Error(w, "Не удалось получить имя хоста", http.StatusInternalServerError)
        return
    }

    currentTime := time.Now().Format(time.RFC3339)
    rand.Seed(time.Now().UnixNano())
    randomNumber := rand.Intn(10001) // от 0 до 10000 включительно

    response := Response{
        Hostname:     hostname,
        CurrentTime:  currentTime,
        RandomNumber: randomNumber,
    }

    w.Header().Set("Content-Type", "application/json")
    jsonData, err := json.Marshal(response)
    if err != nil {
        http.Error(w, "Ошибка при генерации JSON", http.StatusInternalServerError)
        return
    }

    w.Write(jsonData)
}

func main() {
    http.HandleFunc("/", handler)
    port := "8081"
    fmt.Printf("Сервер запущен на порту %s\n", port)
    log.Fatal(http.ListenAndServe(":"+port, nil))
}


project/
│
├── ansible.cfg           # Настройки Ansible
├── inventory.ini         # Инвентори-файл
├── playbooks/            # Директория с плейбуками
│   └── test_nginx.yml
│
├── roles/                # Директория с ролями
│   ├── nginx/            # Роль Nginx
│   │   ├── tasks/
│   │   │   └── main.yml
│   │   ├── files/
│   │   ├── templates/
│   │   ├── handlers/
│   │   ├── meta/
│   │   └── vars/
│   └── other_role/       # Другие роли
│       ├── tasks/
│       └── ...
└── ...

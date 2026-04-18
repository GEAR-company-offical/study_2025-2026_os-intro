---
marp: true
theme: default
paginate: true
size: 16:9
---

# Лабораторная работа №10  
## Текстовый редактор vi  

Козин Иван Евгеньевич  
НКАбд-03-25  

---

# Цель работы

Познакомиться с Linux  
и освоить редактор vi  

---

# Задачи

- изучить vi  
- освоить режимы  
- создать и изменить файл  

---

# Что такое vi

vi — текстовый редактор Linux  

Используется для:
- создания файлов  
- редактирования  

---

# Режимы vi

1. Командный  
2. Вставки  
3. Последней строки  

---

# Командный режим

- перемещение  
- удаление  
- команды  

Примеры:  
dd — удалить строку  
u — отмена  

---

# Режим вставки

Переход: i  

Выход: Esc  

---

# Режим последней строки

Команды:  
:w  
:wq  
:q!  

---

# Создание каталога

mkdir -p ~/work/os/lab06  
cd ~/work/os/lab06  

![](src/image.png)

---

# Создание файла

vi hello.sh  

```
#!/bin/bash  
HELL=Hello  
function hello {  
LOCAL HELLO=World  
echo $HELLO  
}  
echo $HELLO  
hello  

```

![](src/image-1.png)

---

# Сохранение

:wq  
chmod +x hello.sh  

![](src/image-2.png)

---

# Первый запуск

./hello.sh  

Ошибка:  
LOCAL: command not found  

![](src/image-3.png)

---

# Редактирование

vi hello.sh  

Исправления:  
HELL → HELLO  
LOCAL → local  

![](src/image-4.png)

---

# Добавление строки

echo $HELLO  

Команды:  
o  
dd  
u  

![](src/image-5.png)

---

# Итоговый файл
```
#!/bin/bash  
HELLO=Hello  
function hello {  
local HELLO=World  
echo $HELLO  
}  
echo $HELLO  
hello  
echo $HELLO  
```
---

# Финальный запуск

./hello.sh  

Результат:  
Hello  
World  
Hello  

![](src/image-6.png)

---

# Вывод

- изучен vi  
- освоены режимы  
- получены навыки редактирования  

vi — важный инструмент Linux  

---
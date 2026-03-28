---
marp: true
theme: default
paginate: true
size: 16:9
html: true
---

<style>
section.img {
  display: flex;
  justify-content: center;
  align-items: center;
   -align: center;
}
section.img img {
  display: block;
  margin: auto;
  max-width: 90%;
  max-height: 90%;
}
</style>

# Лабораторная работа №7
## Архитектура компьютеров и операционные системы  
### Раздел «Операционные системы»

**Тема:** Анализ файловой системы Linux. Команды для работы с файлами и каталогами  

**Выполнил:** Козин Иван Евгеньевич  
**Группа:** НКАбд-03-25  

---

# Цель работы

Ознакомление с файловой системой Linux, её структурой, именами и содержимым каталогов.  
Приобретение практических навыков по применению команд для работы с файлами и каталогами, управлению процессами, проверке использования диска и обслуживанию файловой системы.

---

# Основные команды

- `touch` – создание файла  
- `cat`, `less`, `head`, `tail` – просмотр файлов  
- `cp` – копирование  
- `mv` – перемещение / переименование  
- `mkdir`, `rmdir`, `rm` – создание и удаление каталогов  
- `chmod` – изменение прав доступа  
- `mount`, `df`, `fsck` – работа с файловыми системами  
- `man` – справочная система  

---

# 1. Подготовка рабочего окружения

Создание каталога `play` и файла `feathers` в домашнем каталоге.
cd ~
touch feathers
mkdir play

 

---

<!-- _class: img -->
![](src/image.png)

---

# 2. Права доступа: каталог australia
mkdir australia
chmod 744 australia
ls -ld australia

 

Права `drwxr--r--` (владелец: rwx, группа: r--, остальные: r--).

---

<!-- _class: img -->
![](src/image-1.png)

---

# 3. Права доступа: каталог play
chmod 711 play
ls -ld play

 

Права `drwx--x--x` (владелец: rwx, группа: --x, остальные: --x).

---

<!-- _class: img -->
![](src/image-2.png)

---

# 4. Права доступа: файл my_os
touch my_os
chmod 544 my_os
ls -l my_os

 

Права `-r-xr--r--` (владелец: r-x, группа: r--, остальные: r--).

---

<!-- _class: img -->
![](src/image-3.png)

---

# 5. Права доступа: файл feathers
chmod 664 feathers
ls -l feathers

 

Права `-rw-rw-r--` (владелец: rw-, группа: rw-, остальные: r--).

---

<!-- _class: img -->
![](src/image-4.png)

---

# 6. Просмотр файла `/etc/passwd`
cat /etc/passwd

 

Файл содержит информацию о пользователях системы.

---

<!-- _class: img -->
![](src/image-5.png)

---

# 7. Копирование файла
cp feathers file.old
ls -l file.old

 

---

<!-- _class: img -->
![](src/image-6.png)

---

# 8. Перемещение файла в каталог
mv file.old play/
ls play/

 

---

<!-- _class: img -->
![](src/image-7.png)

---

# 9. Рекурсивное копирование каталога
cp -r play fun
ls -ld fun
ls fun/

 

---

<!-- _class: img -->
![](src/image-8.png)

---

# 10. Перемещение и переименование каталога
mv fun play/games
ls play/

 

---

<!-- _class: img -->
![](src/image-9.png)

---

# 11. Лишение права на чтение
chmod a-r feathers
ls -l feathers

 

---

<!-- _class: img -->
![](src/image-10.png)

---

# 12. Попытка чтения
cat feathers

 

Доступ запрещён – ожидаемый результат.

---

<!-- _class: img -->
![](src/image-11.png)

---

# 13. Попытка копирования
cp feathers feathers_copy

 

Также отказ в доступе.

---

<!-- _class: img -->
![](src/image-12.png)

---

# 14. Восстановление чтения
chmod a+r feathers
ls -l feathers

 

---

<!-- _class: img -->
![](src/image-13.png)

---

# 15. Лишение права выполнения каталога
chmod a-x play
ls -ld play

 

---

<!-- _class: img -->
![](src/image-14.png)

---

# 16. Попытка входа в каталог
cd play

 

Ошибка: нет права `x`.  
Возврат в домашний каталог: `cd ~`

---

<!-- _class: img -->
![](src/image-15.png)

---

# 17. Возврат права выполнения
chmod a+x play
ls -ld play

 

---

<!-- _class: img -->
![](src/image-16.png)

---

# 18. Анализ смонтированных ФС
mount

 

Вывод содержит точки монтирования, типы ФС и параметры.

---

<!-- _class: img -->
![](src/image-17.png)

---

# 19. Просмотр `/etc/fstab`
cat /etc/fstab

 

Файл описывает автоматически монтируемые ФС.

---

<!-- _class: img -->
![](src/image-19.png)

---

# 20. Использование диска
df -h

 

Отображает занятое и свободное пространство на всех смонтированных ФС.

---

<!-- _class: img -->
![](src/image-20.png)

---

# 21. Справочная система
man mount
man fsck
man mkfs
man kill

 

Изучены man-страницы для углублённого понимания команд.

---

<!-- _class: img -->
![](src/image-18.png)

---

# Вывод

- Изучены команды для работы с файлами и каталогами (`touch`, `cp`, `mv`, `mkdir`, `rm`)
- Освоено изменение прав доступа (`chmod`)
- Проведён анализ смонтированных файловых систем (`mount`, `df`, `/etc/fstab`)
- Изучена справочная система `man`
- Получены практические навыки администрирования на уровне командной строки

---

# Спасибо за внимание
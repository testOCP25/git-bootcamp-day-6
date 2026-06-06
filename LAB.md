# Содержание
- [Содержание](#содержание)
- [LAB — день 6](#lab--день-6)
  - [Базовая задача — `01-clean-history`](#базовая-задача--01-clean-history)
    - [Часть 0 — исследование пяти «грязных» коммитов](#часть-0--исследование-пяти-грязных-коммитов)
    - [Часть 1 — `rebase -i`](#часть-1--rebase--i)
    - [Часть 2 — cherry-pick](#часть-2--cherry-pick)
  - [⭐1 — git stash](#1--git-stash)
  - [⭐2 — cherry-pick с конфликтом](#2--cherry-pick-с-конфликтом)


# LAB — день 6


## Базовая задача — `01-clean-history`

### Часть 0 — исследование пяти «грязных» коммитов

По одной строке на коммит — что он добавляет в проект:

| Коммит на `feat/rds` | Что добавляет (1 строка) |
|----------------------|--------------------------|
| `начало rds` | `db_name, db_username, db_password в variables.tf` |
| `wip` | `resoursces в main.tf` |
| `fix` | `resoursces в main.tf` |
| `sg для базы` | `resoursces в main.tf` |
| `аутпут готов` | `endpoint в outputs.tf` |

```bash
# команды, которыми смотрели:
# git log --oneline -5
# git show HEAD~N
```

### Часть 1 — `rebase -i`

Какие команды в редакторе использовали для каждого из 5 коммитов и почему:

| Исходное сообщение | Команда (`reword`/`fixup`/`squash`/…) | Зачем |
|--------------------|----------------------------------------|-------|
| начало rds | `pick` | `Основной коммит, на его основе объединям еще 2 следующих` |
| wip | `squash` | `Добавляем в один коммит, изменяем main.tf` |
| fix | `squash` | `Добавляем в один коммит, изменяем main.tf` |
| sg для базы | `pick` | `Этот просился к первому, но чтобы не оставлять один коммит, сделал его вторым основным` |
| аутпут готов | `squash` | `Добавляем ко второму коммиту` |

 `fixup` отличается от `squash` тем, что `squash` объединяет изменения и открывает редактор, а `fixup` объединяет изменения, но отбрасывает сообщение фиксируемого коммита.

```bash
# git log --oneline feat/rds после rebase
* fc485f1 (HEAD -> feat/rds) feat(rds): add security group and db endpoint
* a1e3403 feat(rds): new rds, db variables and credentials
* e18b12c (origin/main, origin/HEAD, main) feat(outputs): expose public IP and instance ID
* 99ba77f feat(compute): add EC2 instance and key pair
* 9f4b838 feat(network): add VPC, subnets and security groups
* cb013f5 init: scaffold terraform project structure
```

### Часть 2 — cherry-pick

- Хеш хотфикса на `main`: `f21647e`
- Хеш cherry-pick коммита на `release/1.0`: `c42ba77`
- Хеши разные, потому что `cherry-pick` создаёт новый коммит с новым временем создания, новым автором (если не указан -x флаг для сохранения оригинального), а главное — с новым родительским коммитом, который отличается от родителя исходного коммита в другой ветке. Даже если изменения в файлах идентичны, метаданные и позиция в графе коммитов делают хеш уникальным.`

```bash
# git log --oneline release/1.0 -3
c42ba77 (HEAD -> release/1.0) fix(compute): upgrade instance_type from t2.micro to t3.micro
e18b12c (origin/main, origin/HEAD) feat(outputs): expose public IP and instance ID
99ba77f feat(compute): add EC2 instance and key pair
```

---

## ⭐1 — git stash

**Stash vs WIP-коммит (2–3 предложения):**

[FIXME: когда достаточно stash, когда лучше WIP-коммит + push feature-ветки — другая машина, коллеги, срок хранения черновика]

```bash
# git stash list   # после pop — пуст
```

**Скриншоты (1–2 шт.):**

![FIXME: stash list после push / git status после pop ](screenshots/star1-stash-1.png)

---

## ⭐2 — cherry-pick с конфликтом

**Что конфликтовало и почему:**

[FIXME: контекст instance_type на release/1.0 и main разный, patch не применился автоматически]

**Как разрешили:**

[FIXME: оставили t2.small и добавили instance_monitoring = true]

```hcl
# фрагмент terraform.tfvars на release/1.0 после cherry-pick --continue
[FIXME: фрагмент terraform.tfvars после разрешения конфликта]
```

**Скриншоты (1–2 шт.):**

![FIXME: tfvars с маркерами конфликта / git log с cherry-pick trailer ](screenshots/star2-cherry-pick-1.png)

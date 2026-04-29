# Веди — лендинг + CMS

Production-ready статический сайт + лёгкая CMS на JSON.

## Структура

```
site/
├── index.html              # Главная (Hero, Trust, Problem, Solution, Steps, How, Tariffs, FAQ, CTA)
├── privacy.html            # Политика конфиденциальности (ФЗ-152)
├── terms.html              # Публичная оферта
├── 404.html                # Страница «не найдено»
├── colors_and_type.css     # Дизайн-система (палитра + шрифты)
├── manifest.webmanifest    # PWA-манифест
├── robots.txt              # Поисковикам
├── sitemap.xml             # Карта сайта
├── _headers                # Cloudflare Pages: безопасность + кэш
├── _redirects              # Cloudflare Pages: редиректы + 404
├── .nojekyll               # GitHub Pages: не обрабатывать Jekyll'ом
├── wrangler.toml           # Cloudflare Pages CLI
├── deploy.sh               # Хелпер-скрипт для preview/cloudflare/github
├── .github/workflows/deploy.yml  # GitHub Actions автодеплой
├── assets/                 # Логотипы (сова)
├── content/
│   └── site.json           # Контент сайта (бренд, тарифы, FAQ, trust, steps)
└── admin/
    └── index.html          # CMS: редактор + просмотр заявок
```

## Запуск локально

```bash
./deploy.sh preview
# или вручную
python3 -m http.server 8080
```

- Сайт: http://localhost:8080/
- CMS: http://localhost:8080/admin/

## Заявки с сайта

Форма заявки работает в трёх режимах одновременно:

1. **mailto** — открывает почтовый клиент с готовым письмом на `antonkuzmenkov@gmail.com` (надёжный fallback без бэкенда)
2. **localStorage** — заявка сохраняется в браузере посетителя
3. **API endpoint** (по желанию) — раскомментировать в `index.html` строку с `fetch('https://formspree.io/f/...')` или Telegram Bot API

В CMS на вкладке «Заявки» видны те, что лежат в localStorage **этого** браузера. Для централизованной воронки — подключить Formspree/Tally/Telegram.

## Редактирование контента

1. Открыть `admin/index.html`
2. Изменить любые поля (бренд, hero, trust, шаги, тарифы, FAQ)
3. Кликнуть **Скачать site.json**
4. Заменить файл `content/site.json` скачанной версией
5. Обновить страницу — изменения видны

> Для полностью online-редактирования (без скачать-заменить) подключить **Decap CMS** через Git Gateway.

## Деплой

### Вариант 1: Cloudflare Pages (рекомендуется)

```bash
./deploy.sh cloudflare
```

Или вручную:
1. Положить папку `site/` в GitHub-репо
2. Cloudflare Pages → Connect Git → выбрать репо
3. Build command: пусто. Output directory: `.` (или `site` если папка вложена)
4. Подключить домен `vedi.app` (или любой ваш)

**Цена:** $0 + ~$10/год за домен.

### Вариант 2: GitHub Pages (с автодеплоем)

```bash
./deploy.sh github
```

После пуша:
1. Settings → Pages → Source: **GitHub Actions**
2. Workflow `.github/workflows/deploy.yml` сам всё развернёт при каждом пуше
3. Доступ по `https://<username>.github.io/<repo>/`

**Цена:** $0.

### Вариант 3: Подключение Decap CMS

Чтобы редактировать контент онлайн без скачивания JSON:

1. В `admin/index.html` подключить `<script src="https://unpkg.com/decap-cms@^3.0.0/dist/decap-cms.js"></script>`
2. Создать `admin/config.yml` с описанием полей `site.json`
3. Подключить Git Gateway (бесплатный OAuth Cloudflare/GitHub)
4. Контент-редакторы получают вход через email и публикуют прямо в Git

## Что зашито

- **Бренд:** Веди, antonkuzmenkov@gmail.com, логотип сова
- **Дизайн:** Веди design system (индиго #4F46E5, фиолет #7C3AED, голубой #3B82F6)
- **Шрифты:** Manrope (display) + Inter (body)
- **Контент:** взят из `vedi-investor-mendeleev.pptx` и `vedi-novator-moskvy-2026.pptx`
- **Тарифы:** Звонок 2 990, Близкий 5 990 (флагман), Забота 14 900, Корпорат 24 900

## Особенности

- Glassmorphism + анимированные градиентные blob в фоне
- Sticky header с blur-эффектом
- Живые часы на mock-планшете в Hero
- Reveal-анимации при скролле (`prefers-reduced-motion` поддерживается)
- Модальная форма заявки + RU phone маска + валидация
- Cookie-баннер (ФЗ-152)
- Skip-link и ARIA-атрибуты для accessibility
- JSON-LD Organization для поисковой выдачи
- OG-метатеги для шеринга
- PWA-манифест (можно установить как приложение)
- Адаптив: 480 / 960 / desktop
- 404 с фирменной графикой

## Доменное имя

Рекомендуемые варианты для регистрации:
- `vedi.app` — основной (англоязычный, премиум-зона)
- `vedi.life` — альтернатива
- `вéди.рф` — кириллический, для пожилой аудитории
- `vedi.ru` — короткий и узнаваемый

Регистраторы: REG.RU, RU-CENTER, Namecheap, Cloudflare Registrar (без наценок).

## Следующие шаги

- [ ] Зарегистрировать домен
- [ ] Задеплоить на Cloudflare Pages
- [ ] Подключить Formspree/Tally для централизованной воронки
- [ ] Подключить Yandex.Metrica
- [ ] Создать OG-image (1200×630) с логотипом и слоганом
- [ ] Подключить Decap CMS для онлайн-редактирования
- [ ] Подать уведомление в РКН (оператор персональных данных)

## Контакты

При клике на «Оставить заявку» — открывается модалка с формой. Mailto на `antonkuzmenkov@gmail.com`.

Для масштабирования воронки рекомендую:
- **Tally.so** — бесплатные формы, CSV-экспорт, Slack/Telegram уведомления
- **Telegram Bot** — заявка → сообщение в ваш чат через Bot API
- **CRM** (Bitrix24, amoCRM, Notion) — для масштабирования

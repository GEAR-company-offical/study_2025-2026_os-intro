# =========================================
# Makefile (Linux/Fedora) — аналог твоего .bat
# =========================================

REPORT := report.md
SLIDES := slides.md
LINKS  := links.md
DIST   := slides_and_reports

# Marp CLI: если установлен глобально через npm -> marp
# Можно переопределить при запуске: make MARP=/path/to/marp
MARP   := marp

PANDOC := pandoc

# PDF engine + fonts (должны быть установлены в системе)
PDF_ENGINE := xelatex
LANG := ru
MAINFONT := DejaVu Serif
SANSFONT := DejaVu Sans
MONOFONT := DejaVu Sans Mono

# Временные расширения (root и dist)
TMP_EXT := aux log out tex toc nav snm vrb synctex.gz

.PHONY: all build clean clean-root clean-dist post-clean check copy-assets zip

all: build

# -----------------------------
# Главная сборка (как bat)
# -----------------------------
build: clean-root clean-dist check \
       $(DIST)/report.docx \
       $(DIST)/report.pdf  \
       $(DIST)/report.md   \
       $(DIST)/slides.html \
       copy-assets         \
       $(DIST)/slides.pdf  \
       $(DIST)/slides.md   \
       $(DIST)/links.md    \
       zip                 \
       post-clean
	@echo
	@echo "============================="
	@echo "DONE ✅  Check $(DIST)/"
	@echo "============================="

# -----------------------------
# Проверки
# -----------------------------
check:
	@test -f "$(REPORT)" || (echo "[ERROR] $(REPORT) not found" && exit 1)
	@test -f "$(SLIDES)" || (echo "[ERROR] $(SLIDES) not found" && exit 1)
	@command -v "$(PANDOC)" >/dev/null 2>&1 || (echo "[ERROR] pandoc not found" && exit 1)
	@command -v "$(PDF_ENGINE)" >/dev/null 2>&1 || (echo "[ERROR] xelatex not found" && exit 1)
	@command -v "$(MARP)" >/dev/null 2>&1 || (echo "[ERROR] marp not found (install marp-cli or set MARP=...)" && exit 1)

# -----------------------------
# Очистка мусора в корне
# -----------------------------
clean-root:
	@rm -rf DOCX PDF HTML 2>/dev/null || true

# -----------------------------
# Полная очистка выходной папки
# -----------------------------
clean-dist:
	@echo "Cleaning $(DIST) folder..."
	@rm -rf "$(DIST)" 2>/dev/null || true
	@mkdir -p "$(DIST)"

# -----------------------------
# Report -> DOCX
# -----------------------------
$(DIST)/report.docx: $(REPORT) | $(DIST)
	@echo
	@echo "[1/7] Report -> DOCX"
	@$(PANDOC) "$(REPORT)" -o "$@"

# -----------------------------
# Report -> PDF (Cyrillic-safe)
# -----------------------------
$(DIST)/report.pdf: $(REPORT) | $(DIST)
	@echo
	@echo "[2/7] Report -> PDF (xelatex + fonts)"
	@$(PANDOC) "$(REPORT)" -o "$@" --pdf-engine="$(PDF_ENGINE)" \
		-V lang="$(LANG)" \
		-V mainfont="$(MAINFONT)" \
		-V sansfont="$(SANSFONT)" \
		-V monofont="$(MONOFONT)"

# copy report.md
$(DIST)/report.md: $(REPORT) | $(DIST)
	@cp -f "$(REPORT)" "$@"

# -----------------------------
# Slides -> HTML (Marp)
# -----------------------------
$(DIST)/slides.html: $(SLIDES) | $(DIST)
	@echo
	@echo "[3/7] Slides -> HTML (Marp)"
	@$(MARP) "$(SLIDES)" --html --allow-local-files -o "$@"

# -----------------------------
# Copy images so HTML works
# -----------------------------
copy-assets:
	@echo
	@echo "[4/7] Copy images for HTML (src/assets -> $(DIST))"
	@if [ -d "src" ]; then rm -rf "$(DIST)/src"; mkdir -p "$(DIST)"; cp -a "src" "$(DIST)/src"; fi
	@if [ -d "assets" ]; then rm -rf "$(DIST)/assets"; mkdir -p "$(DIST)"; cp -a "assets" "$(DIST)/assets"; fi

# -----------------------------
# Slides -> PDF (Marp)
# -----------------------------
$(DIST)/slides.pdf: $(SLIDES) | $(DIST)
	@echo
	@echo "[5/7] Slides -> PDF (Marp)"
	@$(MARP) "$(SLIDES)" --pdf --allow-local-files -o "$@"

# copy slides.md
$(DIST)/slides.md: $(SLIDES) | $(DIST)
	@cp -f "$(SLIDES)" "$@"

# -----------------------------
# Links (optional)
# -----------------------------
$(DIST)/links.md: | $(DIST)
	@echo
	@echo "[6/7] Links (optional)"
	@if [ -f "$(LINKS)" ]; then cp -f "$(LINKS)" "$@"; else true; fi

# -----------------------------
# sources.zip (report+slides+links+src+assets if exist)
# -----------------------------
zip:
	@echo
	@echo "[7/7] sources.zip"
	@rm -f "$(DIST)/sources.zip" 2>/dev/null || true
	@ZIPLIST="$(REPORT) $(SLIDES)"; \
	if [ -f "$(LINKS)" ]; then ZIPLIST="$$ZIPLIST $(LINKS)"; fi; \
	if [ -d "src" ]; then ZIPLIST="$$ZIPLIST src"; fi; \
	if [ -d "assets" ]; then ZIPLIST="$$ZIPLIST assets"; fi; \
	zip -r "$(DIST)/sources.zip" $$ZIPLIST >/dev/null

# -----------------------------
# Очистка временных файлов
# -----------------------------
post-clean:
	@echo
	@echo "Checking for temporary files..."
	@for ext in $(TMP_EXT); do rm -f "$(DIST)"/*.$$ext 2>/dev/null || true; done
	@echo
	@echo "Post-clean: remove junk in project root..."
	@rm -rf DOCX PDF HTML 2>/dev/null || true
	@for ext in $(TMP_EXT); do rm -f *.$$ext 2>/dev/null || true; done

# -----------------------------
# convenience
# -----------------------------
clean: clean-root clean-dist post-clean

# dist folder target (order-only prerequisite)
$(DIST):
	@mkdir -p "$(DIST)"
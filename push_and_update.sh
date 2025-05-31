#!/bin/zsh

# Ejecutar los dos comandos:
# chmod +x push_and_update.sh
# ./push_and_update.sh "push automatically"

# Verifica que se pase un mensaje de commit
if [[ -z "$1" ]]; then
  echo "Uso: $0 'mensaje de commit'"
  exit 1
fi

# Verifica que se pase un mensaje de commit
if [[ -z "$1" ]]; then
  echo "Uso: $0 'mensaje de commit'"
  exit 1
fi

echo "📦 Cambiando a main..."
git checkout main || { echo "❌ No se pudo cambiar a main"; exit 1 }
git pull origin main || { echo "❌ No se pudo actualizar main"; exit 1 }

echo "📝 Commit en main..."
git add .
git commit -m "$1" || echo "⚠️  No hubo cambios para commitear"
git push origin main

echo "🔄 Actualizando otras ramas locales con cambios de main..."
for branch in $(git for-each-ref --format='%(refname:short)' refs/heads/); do
  if [[ "$branch" != "main" ]]; then
    echo "🔀 Cambiando a $branch..."
    git checkout "$branch" || { echo "⚠️ No se pudo cambiar a $branch"; continue }
    git merge main || echo "⚠️ Conflicto al hacer merge en $branch, resolvelo manualmente"
    git push origin "$branch"
  fi
done

git checkout main
echo "✅ Todo actualizado y de vuelta en main."
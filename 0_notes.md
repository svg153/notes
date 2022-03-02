# notes

## mapa de personalidad

- <https://www.javiergarzas.com/2019/01/modelos-para-ver-el-mapa-de-personalidad-de-un-equipo-agil-tambien.html>
- <https://www.javiergarzas.com/2021/11/caracterizando-a-un-equipo-agil-desde-las-expectativas-innatas-de-cada-persona-por-que-algunas-estrategias-de-transformacion-agil-no-funcionan-con-ciertas-personas.html>

- Eneagrama
  - Tipo 1: El Perfeccionista
  - Tipo 2: El Ayudador
  - Tipo 3: El Triunfador
  - Tipo 4: El Melancólico
  - Tipo 5: El Investigador
  - Tipo 6: El Leal
  - Tipo 7: El Entusiasta
  - Tipo 8: El Líder
  - Tipo 9: El Pacificador
- Belbin
  - <https://www.smartsheet.com/how-to-use-team-roles-to-boost-performance>
  - [![roles](https://www.smartsheet.com/sites/default/files/styles/1300px/public/IC-Belbins-roles-Game-of-Thrones.jpg?itok=MmJUaG1Y)](https://www.smartsheet.com/sites/default/files/styles/1300px/public/IC-Belbins-roles-Game-of-Thrones.jpg?itok=MmJUaG1Y)
- Myers-Briggs o MBTI
- DISC

## GitHub

### Get all labels in GitHub organization

Github CLI alias [`repos-name-all` in `gh/config.yml`](https://github.com/svg153/configLinux/blob/2272f292cc8c49ddf484d8955a8bbc7ae7a08d7c/.config/gh/config.yml#L22)

Generate a github token

Go to [label-exporter clone](https://github.com/svg153/label-exporter/)

Change: "UUUUU", "XXXXX"

```bash
GITHUB_TOKEN="XXXXX"
USER="UUUUU"
for r in $(gh repos-name-all "${USER}"); do make docker-repo token="${GITHUB_TOKEN}" org_label="${USER}" repo_label="${r}" >> labels.yaml; done
yq 'unique_by(.name) | sort_by(.name)' labels.yaml > labels_uniqs.yaml
```

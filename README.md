![Dark Path to revenge](assets/logo.png)
# Sumário

1. [Finalidade](#finalidade)
2. [Resumo](#resumo)
3. [Características](#caracteristicas)
4. [Plataformas](#plataformas)
5. [Engine](#engine)
6. [Equipe](#equipe)
7. [Lista de tarefas](#listadetarefas)
    1. [Jogador](#jogador)
    2. [Inimigos](#inimigos)
    3. [Level 01](#level01)
    4. [Interface](#interface)
8. [Hierarquia](#hierarquia)
9. [Observações gerais](#observacoes)

## Finalidade
<a name="finalidade"></a>
Projeto de desenvolvimento de um jogo para à disciplina de Mêcanicas e Balanceamento de Jogos.

## Resumo
<a name="resumo"></a>
A jornada de um homem em busca de vingança!

## Características
<a name="caracteristicas"></a>
- 2D
- Plataforma
- Ação/Terror

## Plataformas
<a name="plataformas"></a>
- Windows
- Linux

## Engine
<a name="engine"></a>
- Godot 3.0

## Equipe
<a name="equipe"></a>
- Airton Everton
- Alexandre Alyson
- Matthews Welisson

## Lista de tarefas
<a name="listadetarefas"></a>

### Jogador
<a name="jogador"></a>
- [x] Animação 
- [x] Movimentação
- [x] Pulo duplo
- [x] Deslizar
- [ ] Usar escada
- [x] Ataques com espada em solo
- [x] Ataques com espada no ar
- [x] Ataques à distância com magia
- [ ] Habilidade especial
- [x] Coleta/Utilização de itens
- [x] Morte

### Inimigos
<a name="inimigos"></a>
- [x] Animação 
- [x] Patrulhamento
- [x] Ataque
- [x] Morte
- [ ] Itens
- [ ] Conjuração
- [ ] Transformação

### Level
<a name="level01"></a>
- [x] Esboço
- [ ] Quebra-cabeça
- [x] Eventos
- [x] tileset
- [ ] Áudio
- [ ] \(Opcional) Efeitos especiais

### Interface
<a name="interface"></a>
- [x] Telas
- [x] Menus
- [ ] \(Opcional) Inventário
- [x] \(Opcional) Salvamento
- [x] \(Opcional) Carregamento
- [x] HUD

## Hierarquia
<a name="hierarquia"></a>
Representação hierárquica dos arquivos
**Atualizar depois**
```
Dark-Path-to-Revenge
├── assets
│   └── Enemies
│   │   └── Andarilho
│   │   └── Bruxa
│   │   └── ...
│   └── Enviroment
│   │   └── Caverna
│   │   └── Floresta
│   │   └── Ruinas
│   └── GUI
│   └── Itens
│   │   └── Artefatos
│   │   └── Consumiveis
│   └── Parallax
│   │   └── Caverna
│   │   └── Floresta
│   │   └── Ruinas
│   └── player
│   └── vfx
│   └── TTF
├── scenes
│   └── Enemies
│   └── GUI
│   └── Itens
│   └── Levels
│   └── player
│   └── Screens
├── scripts
│   └── Enemies
│   └── General
│   └── GUI
│   └── Itens
│   └── player
│   └── Screens
└── Sounds
    └── Enemies
    └── Enviroment
    └── GUI
    └── player
```

## Observações gerais
<a name="observacoes"></a>
- Coloque aqui qualquer consideração que achar necessária.

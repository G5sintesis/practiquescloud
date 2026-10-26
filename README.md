# ☁️ Pràctiques Cloud Computing — Pt1.4 (Terraform & AWS)

| Camp | Detall |
| :--- | :--- |
| **Centre Educatiu** | INS Provençana (Departament d'Informàtica) |
| **Cicle Formatiu** | CFGS Administració de Sistemes Informàtics en Xarxa (ASIX2) |
| **Mòdul Optatiu** | Cloud Computing (Curs 2026-2027) |
| **Professors** | Pedro Durán i Joan Muñoz |
| **Alumne** | David Cortés Fontana |
| **Control / Pràctica** | Pt1.4 — Infraestructura com a Codi (IaC) amb Terraform a AWS |
| **Data** | 26/10/2026 |

---

## 📂 Estructura del Repositori

Aquest repositori segueix estrictament l'estructura de carpetes sol·licitada a l'enunciat de la pràctica:

```text
practiquescloud/
├── README.md
├── .gitignore
├── pt1-4-ex1/
│   ├── assets/
│   │   ├── topologia.drawio
│   │   └── topologia.png
│   ├── README.md
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
└── pt1-4-ex2/
    ├── assets/
    │   ├── topologia.drawio
    │   ├── topologia.png
    │   ├── vpc_subnets.png
    │   └── ec2_instances.png
    ├── README.md
    ├── main.tf
    ├── variables.tf
    └── outputs.tf
```

---

## 📑 Índex d'Exercicis

| Exercici | Descripció | Recursos Desplegats a AWS (`us-east-1`) | Documentació |
| :--- | :--- | :--- | :--- |
| **[Exercici 1](./pt1-4-ex1/)** | Primeres instàncies EC2 amb Terraform | 2x EC2 `t3.micro` (Amazon Linux 2023) a la VPC per defecte | [📄 Veure README Exercici 1](./pt1-4-ex1/README.md) |
| **[Exercici 2](./pt1-4-ex2/)** | Disseny i Desplegament de VPC, Subxarxes i EC2 (Consola + IaC) | 1x VPC (`10.0.0.0/16`), 3x Subnets a `us-east-1a` (`/25`, `/23`, `/28`) i 6x EC2 `t3.micro` (AL2023) | [📄 Veure README Exercici 2](./pt1-4-ex2/README.md) |

---

## 🛠️ Requisits Previs

1. **AWS CLI v2** configurat amb les credencials del laboratori d'AWS Academy (`~/.aws/credentials`).
2. **Terraform >= 1.5.0** instal·lat al sistema.
3. Regió d'AWS configurada a **`us-east-1`** (US East - N. Virginia).

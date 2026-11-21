# Regulation of Private Health Insurance and the Age Structure of Beneficiaries in Brazil

**Historical SAS research code and supporting materials (2011)**

This repository documents the data processing and descriptive analysis associated with:

> Stivali, M. (2011). **Regulação da Saúde Suplementar e Estrutura Etária dos Beneficiários** [*Supplementary Health Care Regulation and Age Structure of Beneficiaries*]. *Ciência & Saúde Coletiva*, **16**(9), 3729–3739. https://doi.org/10.1590/S1413-81232011001000010

The study examines changes in the age structure of private health insurance beneficiaries in Brazil between 1998 and 2008, in the context of regulation of age-based premium adjustments. It compares individual and collective arrangements and considers whether demographic aging was associated with younger people leaving private health insurance coverage. The published descriptive evidence indicates an aging beneficiary population, particularly among individual plans, without evidence of an abandonment of private health insurance by younger groups.

## Research materials

The repository contains six historical SAS programs, the published article, and a spreadsheet used in the preparation of tables and figures. The programs have been preserved as research artifacts rather than rewritten as a modern, executable workflow.

```text
2011_Regulacao_Saude_Sup/
├── README.md
├── .gitignore
├── code/
│   ├── age_structure/
│   │   ├── Faixas etárias - Cobertura 980308.sas
│   │   ├── Faixas etárias - Cobertura 980308 - Contratação.sas
│   │   └── Faixas etárias - Cobertura 980308 - Contratação NV.sas
│   ├── dependency_ratios/
│   │   ├── Razao Dependencia.sas
│   │   └── Razao Dependencia 2 - População Planos.sas
│   └── morbidity/
│       └── Prevalências 980308.sas
├── paper/
│   └── Stivali_2011.pdf
└── results/
    └── Tables_After_Review.xls
```

### SAS programs

| Program | Purpose |
| --- | --- |
| `Faixas etárias - Cobertura 980308.sas` | Estimates health plan coverage and age distributions using the 1998, 2003, and 2008 PNAD health supplements; includes exploratory coverage tabulations. |
| `Faixas etárias - Cobertura 980308 - Contratação.sas` | Tabulates age groups and health plan contract categories by sex for the same PNAD waves. |
| `Faixas etárias - Cobertura 980308 - Contratação NV.sas` | Alternative processing of contract information, including an attempt to infer the arrangement for dependents from the plan holder's information. |
| `Razao Dependencia.sas` | Constructs population age-group tabulations used for demographic dependency and aging indicators, covering selected PNAD years from 1978 to 2008. |
| `Razao Dependencia 2 - População Planos.sas` | Produces corresponding tabulations for people covered by private health plans in 1998, 2003, and 2008. |
| `Prevalências 980308.sas` | Processes selected self-reported morbidity indicators by health plan coverage, using SAS macros and the 1998, 2003, and 2008 PNAD health supplements. |

The spreadsheet in `results/` is a historical working file associated with preparation and revision of the article's tables and figures. The publication is in `paper/`.

## Data sources and methods

The principal source is the **Brazilian National Household Sample Survey (PNAD), conducted by IBGE**, including its health supplements for **1998, 2003, and 2008**. Demographic comparisons also draw on the **1978 and 1988** PNAD waves. The published article additionally uses aggregate information from the **National Supplementary Health Agency (ANS)** on health plan beneficiaries and contract categories.

The historical code reads fixed-width PNAD person records, constructs coverage and age-group variables, applies survey weights to descriptive tabulations, and exports intermediate tables for further presentation. In comparing 1998, 2003, and 2008, the study uses a common geographic coverage definition, excluding rural areas of the North region that were added to PNAD coverage in 2004.

The published article discusses important limitations, including the use of reported payment arrangements as a proxy for contract type and differences in self-reported morbidity questions between the 1998 and later PNAD supplements. The ANS-based tables in the published article are not documented by a corresponding standalone processing script in this collection.

## Execution and replication status

**These are historical research files, not a validated replication package.** The SAS programs have not been re-executed or tested in a current SAS environment. They contain absolute Windows paths, depend on original PNAD fixed-width layouts and external data files, and include overlapping or exploratory versions of some analyses. They should not be assumed to run sequentially without adaptation.

The repository does **not** include PNAD microdata, ANS source extracts, or the original SAS datasets. Anyone attempting to reuse the scripts would need to obtain the relevant historical source data and documentation, adjust the local paths, and verify the processing steps and outputs independently.

## Citation

Please cite the published article for research findings:

Stivali, M. (2011). Regulação da Saúde Suplementar e Estrutura Etária dos Beneficiários. *Ciência & Saúde Coletiva*, 16(9), 3729–3739. https://doi.org/10.1590/S1413-81232011001000010

When referring specifically to one of the historical programs, cite the repository and identify the relevant filename and revision.

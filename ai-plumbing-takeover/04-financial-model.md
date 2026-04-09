# 04 — Financial Model

All numbers in USD. Projections are base-case. Bull case +35%, bear case -40%. Raw numbers in [financial-model.csv](financial-model.csv).

## 1. Assumptions

### 1.1 Pricing

| Line | Price | Notes |
|------|-------|-------|
| Node (hardware) | $499 installed | Or $0 upfront + 36-mo SaaS commit |
| Gateway | $399 | One per ~40 sensors |
| SaaS — commercial | $29/sensor/month | Standard tier |
| SaaS — enterprise | $18/sensor/month | >500 sensors |
| SaaS — municipal | $8/sensor/month | >5,000 sensors |
| Plumber network fee | 15% of job value | Avg job $620 blended |
| Insurance data license | $1.20/policy/mo | Per covered building |

### 1.2 Unit economics (commercial building, Year 2 baseline)

| Metric | Value |
|--------|-------|
| Avg sensors per building | 28 |
| Avg gateways per building | 1 |
| Hardware ACV (yr 1) | $13,972 + $399 = $14,371 |
| SaaS ACV | 28 × $29 × 12 = **$9,744/yr** |
| Plumber referral ACV | ~$1,800/yr |
| **Total building ACV** | ~$11,544/yr recurring + $14,371 one-time |
| Hardware COGS @ volume | $24.50 × 28 + $100 = **$786** |
| Hardware gross profit | $14,371 − $786 − $420 install = **$13,165** (91% mg) |
| SaaS gross margin | 85% |
| **Building LTV (5yr)** | $68,000 |
| **Building CAC** (blended channel) | $2,400 |
| **LTV:CAC** | **28:1** |
| Payback period | 4.1 months |

### 1.3 Sales channel mix (by Year 3)

| Channel | % of new ACV | CAC |
|---------|--------------|-----|
| Direct enterprise sales | 40% | $4,200 |
| Insurance carrier referral | 30% | $800 |
| Certified plumber network | 20% | $200 |
| Inbound / marketing | 10% | $1,100 |
| **Blended** | | **$2,400** |

## 2. 5-year P&L (base case)

### 2.1 Revenue

| | Y1 | Y2 | Y3 | Y4 | Y5 |
|---|----|----|----|----|----|
| Buildings live (EOY) | 10 | 85 | 440 | 1,480 | 3,200 |
| Sensors live (EOY) | 240 | 3,200 | 18,000 | 62,000 | 140,000 |
| **Hardware revenue** | $120K | $880K | $3,200K | $8,600K | $16,800K |
| **SaaS revenue** | $48K | $880K | $4,320K | $14,400K | $36,000K |
| **Plumber network fees** | $0 | $180K | $1,280K | $4,200K | $11,800K |
| **Data licensing** | $0 | $0 | $240K | $780K | $2,400K |
| Professional services | $12K | $160K | $460K | $20K | $1,000K |
| **Total revenue** | **$180K** | **$2,100K** | **$9,500K** | **$28,000K** | **$68,000K** |

### 2.2 COGS

| | Y1 | Y2 | Y3 | Y4 | Y5 |
|---|----|----|----|----|----|
| Hardware COGS | $66K | $370K | $1,100K | $2,580K | $4,370K |
| Cloud infra / hosting | $18K | $140K | $600K | $1,680K | $3,600K |
| Payment processing + plumber payouts | $2K | $68K | $320K | $960K | $2,040K |
| Customer success ops | $15K | $90K | $340K | $950K | $2,200K |
| **Total COGS** | **$101K** | **$668K** | **$2,360K** | **$6,170K** | **$12,210K** |
| **Gross profit** | $79K | $1,432K | $7,140K | $21,830K | $55,790K |
| **Gross margin** | **42%** | **58%** | **71%** | **76%** | **79%** |

### 2.3 OpEx

| | Y1 | Y2 | Y3 | Y4 | Y5 |
|---|----|----|----|----|----|
| R&D (eng + ML + hw) | $720K | $1,950K | $3,800K | $6,100K | $9,800K |
| Sales & marketing | $180K | $1,400K | $4,200K | $9,500K | $19,000K |
| G&A | $240K | $680K | $1,400K | $2,800K | $5,200K |
| Manufacturing ramp (non-COGS) | $120K | $380K | $900K | $2,000K | $4,000K |
| Certifications / legal / IP | $90K | $180K | $320K | $600K | $900K |
| **Total OpEx** | **$1,350K** | **$4,590K** | **$10,620K** | **$21,000K** | **$38,900K** |

### 2.4 Bottom line

| | Y1 | Y2 | Y3 | Y4 | Y5 |
|---|----|----|----|----|----|
| EBITDA | ($1,271K) | ($3,158K) | ($3,480K) | $830K | $16,890K |
| D&A | $30K | $90K | $220K | $480K | $900K |
| Net income (pre-tax) | ($1,301K) | ($3,248K) | ($3,700K) | $350K | $15,990K |
| Tax (21%, when profitable) | — | — | — | ($74K) | ($3,358K) |
| **Net income** | **($1,301K)** | **($3,248K)** | **($3,700K)** | **$276K** | **$12,632K** |

Note: Y3 shows deeper loss than Y2 due to aggressive S&M scaling ahead of revenue. This is intentional — Year 3 is the "land grab" year where we take the category.

## 3. Cash flow & funding plan

### 3.1 Funding rounds

| Round | Close | Raise | Pre-money | Post-money | Dilution |
|-------|-------|-------|-----------|-----------|----------|
| Pre-seed | Month 0 | $750K | $3.0M | $3.75M | 20% |
| Seed | Month 14 | $4.0M | $16M | $20M | 20% |
| Series A | Month 28 | $18M | $72M | $90M | 20% |
| Series B | Month 46 | $60M | $340M | $400M | 15% |
| **Total raised** | | **$82.75M** | | | ~55% dilution |

### 3.2 Cash balance (EOY)

| | Y1 | Y2 | Y3 | Y4 | Y5 |
|---|----|----|----|----|----|
| Starting cash | $750K | $3,449K | $14,201K | $26,501K | $86,777K |
| + Net income | ($1,301K) | ($3,248K) | ($3,700K) | $276K | $12,632K |
| + Round raised | $0 (pre-seed at start) | $4,000K | $18,000K | $60,000K | $0 |
| − Working capital / CapEx | $0 | $0 | $2,000K | $0 | $2,000K |
| **Ending cash** | **$3,449K** | **$14,201K** | **$26,501K** | **$86,777K** | **$97,409K** |

All fundraising dates land with 12+ months of runway on close. No round is raised from weakness.

## 4. Sensitivity analysis

### 4.1 Revenue sensitivity (Year 5)

| Scenario | Buildings | ARR | Valuation @ 8x |
|---------|-----------|-----|----------------|
| Bear (-40%) | 1,920 | $40.8M | $326M |
| Base | 3,200 | $68M | $544M |
| Bull (+35%) | 4,320 | $91.8M | $734M |
| Category leader (Samsara comp @ 15x) | 3,200 | $68M | $1.02B |

### 4.2 Key drivers, ranked by sensitivity

1. **Sensors per building** (base: 28, range 18-45). Biggest lever.
2. **Monthly churn** (base: 0.6%, range 0.3-1.8%). If churn goes to 2%, Y5 ARR drops 24%.
3. **Insurance deal timing** (base: Q3 Y2). 6-month delay reduces Y3 ARR by ~$2M and Y4 ARR by ~$6M.
4. **Plumber network activation rate** (base: 80% of certified plumbers take a job in the first 60 days).
5. **Hardware COGS** at scale (base: $24.50, range $18-$38). Each $1 of BOM = ~$140K Y5 margin.

## 5. Key SaaS metrics

| Metric | Y2 | Y3 | Y4 | Y5 | Benchmark (top quartile) |
|--------|----|----|----|----|------|
| Net revenue retention | 108% | 118% | 126% | 131% | >120% |
| Gross churn | 3.2% | 2.4% | 1.8% | 1.4% | <2% |
| Payback period (mo) | 14 | 9 | 6 | 5 | <12 |
| Magic number | 0.6 | 1.1 | 1.4 | 1.5 | >1.0 |
| Rule of 40 | (52%) | 93% | 92% | 108% | >40% |
| ARR per FTE | $105K | $198K | $318K | $425K | >$300K |

## 6. Path to profitability

- **Gross margin inflection:** Year 3 crosses 70% (SaaS mix exceeds hardware).
- **EBITDA inflection:** Year 4 turns positive.
- **Net income inflection:** Year 5.
- **Cash-flow positive:** Year 5 Q2.

Past Y5, the business has Samsara-like economics — 75-80% gross margin, 25%+ EBITDA margin, 50%+ growth. That's the $1B+ valuation set.

## 7. Return profile for investors

### Pre-seed investor ($750K at $3M pre)
- Owns 20% at close → ~9% at Series B (after dilution)
- Y5 valuation (base): $544M × 9% = **$49M**
- **~65x return** on the base case
- **~100x** on the bull / category leader case

### Seed investor ($4M at $16M pre)
- Owns 20% at close → ~12% at Series B
- Y5 valuation (base): **$65M** → **16x return**

### Series A investor ($18M at $72M pre)
- Owns 20% at close → ~17% at Series B
- Y5 valuation (base): **$92M** → **5x return**

Investor returns are front-loaded by design. Pre-seed takes the biggest risk and earns the biggest reward. This is non-negotiable in our cap table philosophy.

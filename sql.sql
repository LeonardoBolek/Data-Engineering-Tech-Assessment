┌─────────────────┬─────────────┬─────────┬─────────┬─────────┬─────────┐
│   column_name   │ column_type │  null   │   key   │ default │  extra  │
│     varchar     │   varchar   │ varchar │ varchar │ varchar │ varchar │
├─────────────────┼─────────────┼─────────┼─────────┼─────────┼─────────┤
│ id              │ INTEGER     │ NO      │ PRI     │         │         │
│ delivery_date   │ DATE        │ NO      │         │         │         │
│ vehicle_name    │ VARCHAR     │ NO      │         │         │         │
│ test_track_name │ VARCHAR     │ NO      │         │         │         │
│ mileage         │ INTEGER     │ NO      │         │         │         │
│ duration        │ INTEGER     │ NO      │         │         │         │
└─────────────────┴─────────────┴─────────┴─────────┴─────────┴─────────┘


┌───────┬───────────────┬──────────────┬─────────────────┬─────────┬──────────┐
│  id   │ delivery_date │ vehicle_name │ test_track_name │ mileage │ duration │
│ int32 │     date      │   varchar    │     varchar     │  int32  │  int32   │
├───────┼───────────────┼──────────────┼─────────────────┼─────────┼──────────┤
│     1 │ 2024-07-09    │ Truck 1      │ Track 1         │      45 │      120 │
│     2 │ 2024-07-10    │ Truck 2      │ Track 2         │      75 │      240 │
│     3 │ 2024-07-11    │ Truck 3      │ Track 1         │      15 │       80 │
│     4 │ 2024-07-12    │ Truck 4      │ Track 3         │      62 │      190 │
│     5 │ 2024-07-13    │ Truck 5      │ Track 2         │      28 │      140 │
│     6 │ 2024-07-14    │ Truck 1      │ Track 1         │      52 │      220 │
│     7 │ 2024-07-15    │ Truck 2      │ Track 3         │      72 │      180 │
│     8 │ 2024-07-09    │ Truck 3      │ Track 2         │      68 │      260 │
├───────┴───────────────┴──────────────┴─────────────────┴─────────┴──────────┤
│ 8 rows                                                            6 columns │
└─────────────────────────────────────────────────────────────────────────────┘


SELECT
	vehicle_name,
	test_track_name,
	sum(mileage) AS mileage,
	sum(duration) AS duration
FROM 
	test_vehicle_data 
WHERE 
	delivery_date >= current_date - interval '7 days'
GROUP BY
	vehicle_name,
	test_track_name
ORDER BY vehicle_name, mileage DESC

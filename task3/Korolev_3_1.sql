SELECT
  customer_rk,
  CONCAT(cd_customers.last_nm, " ", cd_customers.first_nm, " ", cd_customers.middle_nm) AS full_name,
  popularity
FROM
  cd_customers
  LEFT JOIN (
    SELECT
        last_nm,
        first_nm, 
        middle_nm,
        COUNT(*) AS popularity
    FROM
      cd_customers
    WHERE
      valid_from_dttm <= NOW()
      AND valid_to_dttm >= NOW()
    GROUP BY
        last_nm,
        first_nm,
        middle_nm
  ) AS popularities
  ON
    cd_customers.last_nm = popularities.last_nm
    AND cd_customers.first_nm = popularities.first_nm
    AND cd_customers.middle_nm = popularities.middle_nm
WHERE
  valid_from_dttm <= NOW()
  AND valid_to_dttm >= NOW()

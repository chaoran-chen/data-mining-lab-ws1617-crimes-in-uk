-- Can takes about 6 hours.
update crimes_uk_crimes_all b
set post_code = s.post_code
from (
	select *
	from
	(
		select
			lsoa_code,
			region_code,
			region_name,
			msoa_code,
			msoa_name,
			substring(postcode1 from '([a-zA-Z]*)') as post_code,
			ROW_NUMBER() OVER (partition by lsoa_code) as rnum
		from post_codes
	) t
	where t.rnum = 1
) s
where b.lsoa_code = s.lsoa_code;

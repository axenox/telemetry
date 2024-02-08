CREATE OR REPLACE VIEW server_component AS
SELECT 
	scl3.id,
	scl3.created_on,
	scl3.modified_on,
	scl3.created_by_user_oid,
	scl3.modified_by_user_oid,
	scl3.server_id,
	scl3.component_id,
	scl3.version AS current_version,
	scl3.installed_on AS last_update_on,
	scl3.update_interval_months
FROM (
		SELECT 
			scl1.server_id,
			scl1.component_id,
			MAX(scl1.installed_on) AS installed_on
		FROM server_component_log scl1 
		GROUP BY scl1.server_id, scl1.component_id
	) scl2 
	INNER JOIN server_component_log scl3 
		ON scl3.server_id = scl2.server_id 
		AND scl3.component_id = scl2.component_id 
		AND scl3.installed_on = scl2.installed_on
WHERE scl3.uninstalled_on IS NULL;
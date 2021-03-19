-- UPDATE carawonga.wp_options SET option_value = '' WHERE option_name = 'active_plugins';
UPDATE wp_options SET option_value = "http" WHERE option_name = "fastvelocity_min_default_protocol";
import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = 'https://knzvyzczilxhwssxaptn.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_uwfy-Ctq4kcVpnBg8zFA1w_sgb7s0Rt';

export const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

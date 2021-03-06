<?php
class AuthController extends AuthControllerCore
{
	public function initContent() {
		FrontController::initContent();

		$this->context->smarty->assign('genders', Gender::getGenders());

		$this->assignDate();

		$this->assignCountries();

		$active_module_newsletter = false;

		if ($module_newsletter = Module::getInstanceByName('blocknewsletter')) {
			$active_module_newsletter = $module_newsletter->active;
		}

		$this->context->smarty->assign('newsletter', (int)$active_module_newsletter);

		$back = Tools::getValue('back');
		$key = Tools::safeOutput(Tools::getValue('key'));

		if ( ! empty($key)) {
			$back .= (strpos($back, '?') !== false ? '&' : '?').'key='.$key;
		}

		if ( ! empty($back)) {
			$this->context->smarty->assign('back', Tools::safeOutput($back));

			if (strpos($back, 'order') !== false) {
				if (Configuration::get('PS_RESTRICT_DELIVERED_COUNTRIES')) {
					$countries = Carrier::getDeliveredCountries($this->context->language->id, true, true);
				}
				else {
					$countries = Country::getCountries($this->context->language->id, true);
				}

				$this->context->smarty->assign(array(
					'inOrderProcess' => true,
					'PS_GUEST_CHECKOUT_ENABLED' => Configuration::get('PS_GUEST_CHECKOUT_ENABLED'),
					'PS_REGISTRATION_PROCESS_TYPE' => Configuration::get('PS_REGISTRATION_PROCESS_TYPE'),
					'sl_country' => (int)Tools::getValue('id_country', Configuration::get('PS_COUNTRY_DEFAULT')),
					'countries' => $countries
				));
			}
		}

		if (Tools::getValue('create_account')) {
			$this->context->smarty->assign('email_create', 1);
		}

		if (Tools::getValue('multi-shipping') == 1) {
			$this->context->smarty->assign('multi_shipping', true);
		}
		else {
			$this->context->smarty->assign('multi_shipping', false);
		}
		
		$this->assignAddressFormat();

		// Call a hook to display more information on form
		$this->context->smarty->assign(array(
			'HOOK_CREATE_ACCOUNT_FORM' => Hook::exec('displayCustomerAccountForm'),
			'HOOK_CREATE_ACCOUNT_TOP' => Hook::exec('displayCustomerAccountFormTop')
		));
		
		if ($this->ajax) {
			// Call a hook to display more information on form
			$this->context->smarty->assign(array(
				'PS_REGISTRATION_PROCESS_TYPE' => Configuration::get('PS_REGISTRATION_PROCESS_TYPE'),
				'genders' => Gender::getGenders()
			));

			$return = array(
				'hasError' => ! empty($this->errors),
				'errors' => $this->errors,
				'page' => $this->context->smarty->fetch((defined('GN_THEME_PATH') ? GN_THEME_PATH : _PS_THEME_DIR_) . 'authentication.tpl'),
				'token' => Tools::getToken(false)
			);
			die(Tools::jsonEncode($return));
		}
		$this->setTemplate(_PS_THEME_DIR_.'authentication.tpl');
	}
}


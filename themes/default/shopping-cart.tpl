{*
* 2007-2012 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2012 PrestaShop SA
*  @version  Release: $Revision: 7476 $
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

{capture name=path}{l s='Your shopping cart' mod='germanext'}{/capture}
<input type="hidden" id="is_shipping_cart" value="{if isset($ONLY_SHIPPING_CART) && $ONLY_SHIPPING_CART}1{else}0{/if}" />
{if isset($ONLY_SHIPPING_CART) && $ONLY_SHIPPING_CART}
{include file="$tpl_dir./breadcrumb.tpl"}
{/if}
{if $opc && !$ONLY_SHIPPING_CART}
<h2><span>4</span> {l s='Finilize Your Purchase' mod='germanext'}</h2>
<p class="gn_validate_order_warning">
    {l s='Please look through the order information again, only place your order when you\'re certain the details are correct' mod='germanext'}
</p>
{/if}
<h1 id="cart_title">{l s='Shopping cart summary' mod='germanext'}</h1>
{if !$ONLY_SHIPPING_CART && $GN_CHECK_PAYMENT && ($PS_CMS_ID_CONDITIONS || $PS_CMS_ID_REVOCATION)}
   <h3 class="condition_title">{l s='Terms of service' mod='germanext'}</h3>
   <p class="checkbox">
      {if isset($PS_CONDITIONS) && $PS_CONDITIONS}
         <input type="checkbox" name="cgv" id="cgv" value="1" />
      {/if}
      {if isset($PS_CMS_ID_CONDITIONS) && $PS_CMS_ID_CONDITIONS}
         <label for="cgv">{l s='I agree to the' mod='germanext'}</label> <a href="{$CMS_CONDITIONS_LINK}" class="fancybox iframe">{l s='terms of service' mod='germanext'}</a>
      {/if}
      {if isset($PS_CMS_ID_REVOCATION) && $PS_CMS_ID_REVOCATION}
         <label>{l s='and' mod='germanext'}</label> <a href="{$CMS_REVOCATION_LINK}" class="fancybox iframe">{l s='terms of revocation' mod='germanext'}</a> {l s='adhire to them unconditionally.' mod='germanext'}
      {/if}
   </p>
{/if}

{if isset($account_created)}
	<p class="success">
		{l s='Your account has been created.' mod='germanext'}
	</p>
{/if}
{if isset($force_step)}
{assign var='current_step' value=$force_step}
{else}
{assign var='current_step' value='summary'}
{/if}
{include file="$tpl_dir./order-steps.tpl"}
{include file="$tpl_dir./errors.tpl"}

{if isset($empty)}
	<p class="warning">{l s='Your shopping cart is empty.' mod='germanext'}</p>
{elseif $PS_CATALOG_MODE}
	<p class="warning">{l s='This store has not accepted your new order.' mod='germanext'}</p>
{else}
	<script type="text/javascript">
	// <![CDATA[
	var currencySign = '{$currencySign|html_entity_decode:2:"UTF-8"}';
	var currencyRate = '{$currencyRate|floatval}';
	var currencyFormat = '{$currencyFormat|intval}';
	var currencyBlank = '{$currencyBlank|intval}';
	var txtProduct = "{l s='product' mod='germanext' js=1}";
	var txtProducts = "{l s='products' mod='germanext' js=1}";
	var deliveryAddress = {$cart->id_address_delivery|intval};
	// ]]>
	</script>
	<p style="display:none" id="emptyCartWarning" class="warning">{l s='Your shopping cart is empty.' mod='germanext'}</p>
   <div id="order-detail-content" class="table_block">
	<table id="cart_summary" class="std">
		<thead>
			<tr>
				<th class="cart_product first_item">{l s='Product' mod='germanext'}</th>
				<th class="cart_description item">{l s='Description' mod='germanext'}</th>
				<th class="cart_ref item">{l s='Ref.' mod='germanext'}</th>
				<th class="cart_unit item">{l s='Unit price' mod='germanext'}</th>
				<th class="cart_quantity item">{l s='Qty' mod='germanext'}</th>
				<th class="cart_total item">{l s='Total' mod='germanext'}</th>
				<th class="cart_delete last_item">&nbsp;</th>
			</tr>
		</thead>
		<tfoot>
		{if $use_taxes}
			{if $priceDisplay}
				<tr class="cart_total_price">
					<td colspan="5">{l s='Total products' mod='germanext'}{if $display_tax_label} {l s='(tax excl.)' mod='germanext'}{/if}{l s=':' mod='germanext'}</td>
					<td colspan="2" class="price" id="total_product">{displayPrice price=$total_products}</td>
				</tr>
			{else}
				<tr class="cart_total_price">
					<td colspan="5">{l s='Total products' mod='germanext'}{if $display_tax_label} {l s='(tax incl.)' mod='germanext'}{/if}{l s=':' mod='germanext'}</td>
					<td colspan="2" class="price" id="total_product">{displayPrice price=$total_products_wt}</td>
				</tr>
			{/if}
		{else}
			<tr class="cart_total_price">
				<td colspan="5">{l s='Total products:' mod='germanext'}</td>
				<td colspan="2" class="price" id="total_product">{displayPrice price=$total_products}</td>
			</tr>
		{/if}
			<tr class="cart_total_voucher" {if $total_discounts == 0}style="display: none;"{/if}>
				<td colspan="5">
				{if $use_taxes}
					{if $priceDisplay}
						{l s='Total vouchers' mod='germanext'}{if $display_tax_label} {l s='(tax excl.)' mod='germanext'}{/if}{l s=':' mod='germanext'}
					{else}
						{l s='Total vouchers' mod='germanext'}{if $display_tax_label} {l s='(tax incl.)' mod='germanext'}{/if}{l s=':' mod='germanext'}
					{/if}
				{else}
					{l s='Total vouchers:' mod='germanext'}
				{/if}
				</td>
				<td colspan="2" class="price-discount price" id="total_discount">
				{if $use_taxes}
					{if $priceDisplay}
						{displayPrice price=$total_discounts_tax_exc}
					{else}
						{displayPrice price=$total_discounts}
					{/if}
				{else}
					{displayPrice price=$total_discounts_tax_exc}
				{/if}
				</td>
			</tr>
			<tr class="cart_total_wrapping" {if $total_wrapping == 0}style="display: none;"{/if}>
				<td colspan="5">
				{if $use_taxes}
					{if $priceDisplay}
						{l s='Total gift-wrapping' mod='germanext'}{if $display_tax_label} {l s='(tax excl.)' mod='germanext'}{/if}{l s=':' mod='germanext'}
					{else}
						{l s='Total gift-wrapping' mod='germanext'}{if $display_tax_label} {l s='(tax incl.)' mod='germanext'}{/if}{l s=':' mod='germanext'}
					{/if}
				{else}
					{l s='Total gift-wrapping:' mod='germanext'}
				{/if}
				</td>
				<td colspan="2" class="price-discount price" id="total_wrapping">
				{if $use_taxes}
					{if $priceDisplay}
						{displayPrice price=$total_wrapping_tax_exc}
					{else}
						{displayPrice price=$total_wrapping}
					{/if}
				{else}
					{displayPrice price=$total_wrapping_tax_exc}
				{/if}
				</td>
			</tr>
			{if isset($cart->id_customer) && $cart->id_customer > 0}
			   {if $use_taxes}
				   {if $priceDisplay}
					   <tr class="cart_total_delivery" {if $shippingCost <= 0} style="display:none;"{/if}>
						   <td colspan="5">{l s='Total shipping' mod='germanext'}{if $display_tax_label} {l s='(tax excl.)' mod='germanext'}{/if}{l s=':' mod='germanext'}</td>
						   <td colspan="2" class="price" id="total_shipping">{displayPrice price=$shippingCostTaxExc}</td>
					   </tr>
				   {else}
					   <tr class="cart_total_delivery"{if $shippingCost <= 0} style="display:none;"{/if}>
						   <td colspan="5">{l s='Total shipping' mod='germanext'}{if $display_tax_label} {l s='(tax incl.)' mod='germanext'}{/if}{l s=':' mod='germanext'}</td>
						   <td colspan="2" class="price" id="total_shipping" >{displayPrice price=$shippingCost}</td>
					   </tr>
				   {/if}
			   {else}
				   <tr class="cart_total_delivery"{if $shippingCost <= 0} style="display:none;"{/if}>
					   <td colspan="5">{l s='Total shipping:' mod='germanext'}</td>
					   <td colspan="2" class="price" id="total_shipping" >{displayPrice price=$shippingCostTaxExc}</td>
				   </tr>
			   {/if}
			{else if isset($CMS_SHIPPING_LINK) && $CMS_SHIPPING_LINK}
			<tr class="cart_total_delivery" {if $shippingCost <= 0} style="display:none;"{/if}>
				<td colspan="5"><span class="shipping_label" style="display: none;">{l s='Total shipping:' mod='germanext'}</span></td>
				<td colspan="2" class="price" id="total_shipping" >
					<div class="gn_adds gn_shipping"> {l s='plus' mod='germanext'}
                        <a href="{$CMS_SHIPPING_LINK}" class="fancybox iframe">{l s='shipping costs' mod='germanext'}</a>
                    </div>
				</td>
			</tr>
			{/if}
			{if $use_taxes}
				{if $priceDisplay}
					<tr class="cart_total_payment" {if $total_payment_tax_exc == 0} style="display:none;"{/if}>
						<td colspan="5" id="payment_cost_name">{$payment_cost_name}</td>
						<td class="price" id="total_payment" colspan="2">{displayPrice price=$total_payment_tax_exc}</td>
					</tr>
				{else}
					<tr class="cart_total_payment"{if $total_payment == 0} style="display:none;"{/if}>
						<td colspan="5" id="payment_cost_name">{$payment_cost_name}</td>
						<td class="price" id="total_payment" colspan="2">{displayPrice price=$total_payment}</td>
					</tr>
				{/if}
			{else}
				<tr class="cart_total_payment"{if $total_payment_tax_exc == 0} style="display:none;"{/if}>
					<td colspan="5" id="payment_cost_name">{$payment_cost_name}</td>
					<td class="price" id="total_payment" colspan="2">{displayPrice price=$total_payment_tax_exc}</td>
				</tr>
			{/if}

			<tr class="cart_total_price">
				<td colspan="5">{l s='Total (tax excl.):'}</td>
				<td colspan="2" class="price" id="total_price_without_tax">{displayPrice price=$total_price_without_tax}</td>
			</tr>
			<tr class="cart_total_tax">
				<td colspan="5">{l s='Total tax:'}</td>
				<td colspan="2" class="price" id="total_tax">{displayPrice price=$total_tax}</td>
			</tr>
			<tr class="cart_total_price">
				<td colspan="5" id="cart_voucher" class="cart_voucher">
				{if $voucherAllowed && $ONLY_SHIPPING_CART}
					{if isset($errors_discount) && $errors_discount}
						<ul class="error">
						{foreach $errors_discount as $k=>$error}
							<li>{$error|escape:'htmlall':'UTF-8'}</li>
						{/foreach}
						</ul>
					{/if}
					<form action="{if $opc}{$link->getPageLink('order-opc.php', true, NULL, "add&amp;shipping_cart=1")}{else}{$link->getPageLink('order.php', true, NULL, "add&amp;shipping_cart=1")}{/if}" method="post" id="voucher">
						<fieldset>
							<p class="title_block"><label for="discount_name">{l s='Vouchers'}</label></p>
							<p>
								<input type="text" class="discount_name" id="discount_name" name="discount_name" value="{if isset($discount_name) && $discount_name}{$discount_name}{/if}" />
							</p>
							<p class="submit"><input type="hidden" name="submitDiscount" /><input type="submit" name="submitAddDiscount" value="{l s='OK'}" class="button" /></p>
						</fieldset>
					</form>
					{if $displayVouchers}
						<p id="title" class="title_offers">{l s='Take advantage of our offers:'}</p>
						<div id="display_cart_vouchers">
						{foreach $displayVouchers as $voucher}
							{if $voucher.code != ''}<span onclick="$('#discount_name').val('{$voucher.code}');return false;" class="voucher_name">{$voucher.code}</span> - {/if}{$voucher.name}<br />
						{/foreach}
						</div>
					{/if}
				{/if}
				</td>
				{if $use_taxes}
				<td colspan="2" class="price total_price_container" id="total_price_container">
					<p>{l s='Total:'}</p>
					<span id="total_price">{displayPrice price=$total_price}</span>
				</td>
				{else}
				<td colspan="2" class="price total_price_container" id="total_price_container">
					<p>{l s='Total:'}</p>
					<span id="total_price">{displayPrice price=$total_price_without_tax}</span>
				</td>
				{/if}
			</tr>
		</tfoot>
		<tbody>
		{foreach $products as $product}
			{assign var='productId' value=$product.id_product}
			{assign var='productAttributeId' value=$product.id_product_attribute}
			{assign var='quantityDisplayed' value=0}
			{* Display the product line *}
			{include file="$tpl_dir./shopping-cart-product-line.tpl" productLast=$product@last productFirst=$product@first}
			{* Then the customized datas ones*}
			{if isset($customizedDatas.$productId.$productAttributeId)}
				{foreach $customizedDatas.$productId.$productAttributeId[$product.id_address_delivery] as $id_customization=>$customization}
					<tr id="product_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}" class="alternate_item cart_item">
						<td colspan="4">
							{foreach $customization.datas as $type=>$custom_data}

								{if $type == $CUSTOMIZE_FILE}
									<div class="customizationUploaded">
										<ul class="customizationUploaded">
											{foreach $datas as $picture}<li><img src="{$pic_dir}{$picture.value}_small" alt="" class="customizationUploaded" /></li>{/foreach}
										</ul>
									</div>
								{elseif $type == $CUSTOMIZE_TEXTFIELD}
									<ul class="typedText">
										{foreach $custom_data as $textField}
											<li>
												{if $textField.name}
													{$textField.name}
												{else}
													{l s='Text #'}{$textField@index+1}
												{/if}
												{l s=':'} {$textField.value}
											</li>
										{/foreach}
										
									</ul>
								{/if}

							{/foreach}
						</td>
						<td class="cart_quantity" colspan="2">
							{if isset($cannotModify) AND $cannotModify == 1}
								<span style="float:left">{if $quantityDisplayed == 0 AND isset($customizedDatas.$productId.$productAttributeId)}{$customizedDatas.$productId.$productAttributeId|@count}{else}{$product.cart_quantity-$quantityDisplayed}{/if}</span>
							{else}
								<div class="cart_quantity_button">
								<a rel="nofollow" class="cart_quantity_up" id="cart_quantity_up_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}" href="{$link->getPageLink('cart', true, NULL, "add&amp;id_product={$product.id_product|intval}&amp;ipa={$product.id_product_attribute|intval}&amp;id_address_delivery={$product.id_address_delivery}&amp;id_customization={$id_customization}&amp;token={$token_cart}")}" title="{l s='Add'}"><img src="{$img_dir}icon/quantity_up.gif" alt="{l s='Add'}" width="14" height="9" /></a><br />
								{if $product.minimal_quantity < ($customization.quantity -$quantityDisplayed) OR $product.minimal_quantity <= 1}
								<a rel="nofollow" class="cart_quantity_down" id="cart_quantity_down_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}" href="{$link->getPageLink('cart', true, NULL, "add&amp;id_product={$product.id_product|intval}&amp;ipa={$product.id_product_attribute|intval}&amp;id_address_delivery={$product.id_address_delivery}&amp;id_customization={$id_customization}&amp;op=down&amp;token={$token_cart}")}" title="{l s='Subtract'}">
									<img src="{$img_dir}icon/quantity_down.gif" alt="{l s='Subtract'}" width="14" height="9" />
								</a>
								{else}
								<a class="cart_quantity_down" style="opacity: 0.3;" id="cart_quantity_down_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}" href="#" title="{l s='Subtract'}">
									<img src="{$img_dir}icon/quantity_down.gif" alt="{l s='Subtract'}" width="14" height="9" />
								</a>
								{/if}
								</div>
								<input type="hidden" value="{$customization.quantity}" name="quantity_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}_hidden"/>
								<input size="2" type="text" value="{$customization.quantity}" class="cart_quantity_input" name="quantity_{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}"/>
							{/if}
						</td>
						<td class="cart_delete">
							{if isset($cannotModify) AND $cannotModify == 1}
							{else}
								<div>
									<a rel="nofollow" class="cart_quantity_delete" id="{$product.id_product}_{$product.id_product_attribute}_{$id_customization}_{$product.id_address_delivery|intval}" href="{$link->getPageLink('cart', true, NULL, "delete&amp;id_product={$product.id_product|intval}&amp;ipa={$product.id_product_attribute|intval}&amp;id_customization={$id_customization}&amp;id_address_delivery={$product.id_address_delivery}&amp;token={$token_cart}")}">{l s='Delete'}</a>
								</div>
							{/if}
						</td>
					</tr>
					{assign var='quantityDisplayed' value=$quantityDisplayed+$customization.quantity}
				{/foreach}
				{* If it exists also some uncustomized products *}
				{if $product.quantity-$quantityDisplayed > 0}{include file="$tpl_dir./shopping-cart-product-line.tpl" productLast=$product@last productFirst=$product@first}{/if}
			{/if}
		{/foreach}
		</tbody>
	{if sizeof($discounts)}
		<tbody>
		{foreach $discounts as $discount}
			<tr class="cart_discount {if $discount@last}last_item{elseif $discount@first}first_item{else}item{/if}" id="cart_discount_{$discount.id_discount}">
				<td class="cart_discount_name" colspan="3">{$discount.name}</td>
				<td class="cart_discount_price"><span class="price-discount">
					{if !$priceDisplay}{displayPrice price=$discount.value_real*-1}{else}{displayPrice price=$discount.value_tax_exc*-1}{/if}
				</span></td>
				<td class="cart_discount_delete">1</td>
				<td class="cart_discount_price">
					<span class="price-discount price">{if !$priceDisplay}{displayPrice price=$discount.value_real*-1}{else}{displayPrice price=$discount.value_tax_exc*-1}{/if}</span>
				</td>
				<td class="price_discount_del">
					<a href="{if $opc}{$link->getPageLink('order-opc', true)}{else}{$link->getPageLink('order', true)}{/if}?deleteDiscount={$discount.id_discount}" class="price_discount_delete" title="{l s='Delete'}">{l s='Delete'}</a>
				</td>
			</tr>
		{/foreach}
		</tbody>
	{/if}
	</table>
</div>

{if $show_option_allow_separate_package}
<p>
	<input type="checkbox" name="allow_seperated_package" id="allow_seperated_package" {if $cart->allow_seperated_package}checked="checked"{/if} />
	<label for="allow_seperated_package">{l s='Send the available products first'}</label>
</p>
{/if}
{if !$opc}
	{if Configuration::get('PS_ALLOW_MULTISHIPPING')}
		<p>
			<input type="checkbox" {if $multi_shipping}checked="checked"{/if} id="enable-multishipping" />
			<label for="enable-multishipping">{l s='I want to specify a delivery address for each individual product.'}</label>
		</p>
	{/if}
{/if}

{if $ONLY_SHIPPING_CART}
<div id="HOOK_SHOPPING_CART">{$HOOK_SHOPPING_CART}</div>
{/if}

{* Define the style if it doesn't exist in the PrestaShop version*}
{* Will be deleted for 1.5 version and more *}
{if !isset($addresses_style)}
	{$addresses_style.company = 'address_company'}
	{$addresses_style.vat_number = 'address_company'}
	{$addresses_style.firstname = 'address_name'}
	{$addresses_style.lastname = 'address_name'}
	{$addresses_style.address1 = 'address_address1'}
	{$addresses_style.address2 = 'address_address2'}
	{$addresses_style.city = 'address_city'}
	{$addresses_style.country = 'address_country'}
	{$addresses_style.phone = 'address_phone'}
	{$addresses_style.phone_mobile = 'address_phone_mobile'}
	{$addresses_style.alias = 'address_title'}
{/if}

{if ((!empty($delivery_option) AND !isset($virtualCart)) OR $delivery->id OR $invoice->id) AND !$opc}
<div class="order_delivery clearfix">
	{if !isset($formattedAddresses)}
	{if $delivery->id}
	<ul id="delivery_address" class="address item">
		<li class="address_title">{l s='Delivery address'}</li>
		{if $delivery->company}<li class="address_company">{$delivery->company|escape:'htmlall':'UTF-8'}</li>{/if}
		<li class="address_name">{$delivery->firstname|escape:'htmlall':'UTF-8'} {$delivery->lastname|escape:'htmlall':'UTF-8'}</li>
		<li class="address_address1">{$delivery->address1|escape:'htmlall':'UTF-8'}</li>
		{if $delivery->address2}<li class="address_address2">{$delivery->address2|escape:'htmlall':'UTF-8'}</li>{/if}
		<li class="address_city">{$delivery->postcode|escape:'htmlall':'UTF-8'} {$delivery->city|escape:'htmlall':'UTF-8'}</li>
		<li class="address_country">{$delivery->country|escape:'htmlall':'UTF-8'} {if $delivery_state}({$delivery_state|escape:'htmlall':'UTF-8'}){/if}</li>
	</ul>
	{/if}
	{if $invoice->id}
	<ul id="invoice_address" class="address alternate_item">
		<li class="address_title">{l s='Invoice address'}</li>
		{if $invoice->company}<li class="address_company">{$invoice->company|escape:'htmlall':'UTF-8'}</li>{/if}
		<li class="address_name">{$invoice->firstname|escape:'htmlall':'UTF-8'} {$invoice->lastname|escape:'htmlall':'UTF-8'}</li>
		<li class="address_address1">{$invoice->address1|escape:'htmlall':'UTF-8'}</li>
		{if $invoice->address2}<li class="address_address2">{$invoice->address2|escape:'htmlall':'UTF-8'}</li>{/if}
		<li class="address_city">{$invoice->postcode|escape:'htmlall':'UTF-8'} {$invoice->city|escape:'htmlall':'UTF-8'}</li>
		<li class="address_country">{$invoice->country|escape:'htmlall':'UTF-8'} {if $invoice_state}({$invoice_state|escape:'htmlall':'UTF-8'}){/if}</li>
	</ul>
	{/if}
	{else}
		{foreach $formattedAddresses as $address}
			<ul class="address {if $address@last}last_item{elseif $address@first}first_item{/if} {if $address@index % 2}alternate_item{else}item{/if}">
				<li class="address_title">{$address.object.alias}</li>
				{foreach $address.ordered as $pattern}
					{assign var=addressKey value=" "|explode:$pattern}
					<li>
					{foreach $addressKey as $key}
						<span class="{if isset($addresses_style[$key])}{$addresses_style[$key]}{/if}">
							{$address.formated[$key]|escape:'htmlall':'UTF-8'}
						</span>
					{/foreach}
					</li>
				{/foreach}
				</ul>
		{/foreach}
		<p class="clear" />
	{/if}
</div>
{/if}
{if isset($GN_CHECK_PAYMENT) && $GN_CHECK_PAYMENT}
    <p class="cart_navigation">
        <a href="{if (isset($smarty.server.HTTP_REFERER) && strstr($smarty.server.HTTP_REFERER, 'order.php')) || !isset($smarty.server.HTTP_REFERER)}{$link->getPageLink('index.php')}{else}{$smarty.server.HTTP_REFERER|escape:'htmlall':'UTF-8'|secureReferrer}{/if}" class="button_large" title="{l s='Continue shopping'}">&laquo; {l s='Continue shopping'}</a>
        {if $ONLY_SHIPPING_CART}
            <a id="button_order" href="{$link->getPageLink('order.php', true)}" class="exclusive" title="{l s='Order' mod='germanext'}">{l s='Order' mod='germanext'}</a>
        {elseif $opc}
            <a href="{$BUTTON_ORDER_HREF}" id="button_order" class="{if ! $PS_CONDITIONS}exclusive_large{else}button_large exclusive disabled{/if}">{l s='Purchase products' mod='germanext'}</a>
        {else}
			<a href="{if $back}{$link->getPageLink('order', true, NULL, 'step=1&amp;back={$back}')}{else}{$link->getPageLink('order', true, NULL, 'step=1')}{/if}" class="exclusive standard-checkout" title="{l s='Next'}">{l s='Next'} &raquo;</a>
			{if Configuration::get('PS_ALLOW_MULTISHIPPING')}
				<a href="{if $back}{$link->getPageLink('order', true, NULL, 'step=1&amp;back={$back}')}{else}{$link->getPageLink('order', true, NULL, 'step=1')}{/if}&amp;multi-shipping=1" class="multishipping-button multishipping-checkout exclusive" title="{l s='Next'}">{l s='Next'} &raquo;</a>
			{/if}
		{/if}
    </p>
{else}
    <p class="cart_navigation">
        {if $ONLY_SHIPPING_CART}
            <a href="{if (isset($smarty.server.HTTP_REFERER) && strstr($smarty.server.HTTP_REFERER, 'order.php')) || !isset($smarty.server.HTTP_REFERER)}{$link->getPageLink('index.php')}{else}{$smarty.server.HTTP_REFERER|escape:'htmlall':'UTF-8'|secureReferrer}{/if}" class="button_large" title="{l s='Continue shopping'}">&laquo; {l s='Continue shopping'}</a>
            <a id="button_order" href="{$link->getPageLink('order.php', true)}" class="exclusive" title="{l s='Order' mod='germanext'}">{l s='Order' mod='germanext'}</a>
        {/if}
    </p>
{/if}

<p class="clear"><br /><br /></p>
<div class="clear"></div>
<p class="cart_navigation_extra">
	<span id="HOOK_SHOPPING_CART_EXTRA">{$HOOK_SHOPPING_CART_EXTRA}</span>
</p>
{/if}


package com.dev.op.core.rest.vipchannel;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.dev.op.core.dto.ResponseModel;
import com.dev.op.core.dto.vipchannel.getDirectionByIdModel;
import com.dev.op.core.dto.vipchannel.getListMangerModel;
import com.dev.op.core.dto.vipchannel.getListPayModel;
import com.dev.op.core.dto.vipchannel.getListPayOneModel;
import com.dev.op.core.dto.vipchannel.getListVoucherModel;
import com.dev.op.core.dto.vipchannel.getListlienteByManagerModel;
import com.dev.op.core.dto.vipchannel.getManagaerCountModel;
import com.dev.op.core.dto.vipchannel.getManagerByIdModel;
import com.dev.op.core.dto.vipchannel.getPayServiceDetailModel;
import com.dev.op.core.dto.vipchannel.getPayServiceDetailMonthModel;
import com.dev.op.core.dto.vipchannel.getPersonByDocumentModel;
import com.dev.op.core.dto.vipchannel.getPersonByIdModel;
import com.dev.op.core.dto.vipchannel.getReferenceByIdModel;
import com.dev.op.core.dto.vipchannel.getVoucherByIdModel;
import com.dev.op.core.facade.vipchannel.CobranzaFacade;
import com.dev.op.core.util.vipchannel.GenericUtil;
import com.dev.op.core.view.vipchannel.pdf.PdfGenerator;

@RestController
@RequestMapping("/api/v1/cobranza")
public class CobranzaRestController {

	@Autowired
	@Qualifier("cobranzaFacade")
	private CobranzaFacade cobranzaFacade;
	
	@GetMapping("/getPersonByDocument/{search}")
	public ResponseEntity<List<getPersonByDocumentModel>> getPersonByDocument(@PathVariable(value="search") String search) {
		
		try{
			List<getPersonByDocumentModel> getPersonByDocument = cobranzaFacade.getPersonByDocument(search);
			if(!GenericUtil.isCollectionEmpty(getPersonByDocument)) {
				return new ResponseEntity<List<getPersonByDocumentModel>>(getPersonByDocument, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getPersonByDocumentModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getPersonByDocumentModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getPersonById/{document}")
	public ResponseEntity<List<getPersonByIdModel>> getPersonById(@PathVariable(value="document") String document) {
		
		try{
			List<getPersonByIdModel> getPersonById = cobranzaFacade.getPersonById(document);
			if(!GenericUtil.isCollectionEmpty(getPersonById)) {
				return new ResponseEntity<List<getPersonByIdModel>>(getPersonById, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getPersonByIdModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getPersonByIdModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getDirectionById/{document}/{code}")
	public ResponseEntity<List<getDirectionByIdModel>> getDirectionById(@PathVariable(value="document") String document,
			@PathVariable(value="code") String code) {
		
		try{
			List<getDirectionByIdModel> getDirectionById = cobranzaFacade.getDirectionById(document, code);
			if(!GenericUtil.isCollectionEmpty(getDirectionById)) {
				return new ResponseEntity<List<getDirectionByIdModel>>(getDirectionById, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getDirectionByIdModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getDirectionByIdModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getReferenceById/{document}/{code}")
	public ResponseEntity<List<getReferenceByIdModel>> getReferenceById(@PathVariable(value="document") String document,
			@PathVariable(value="code") String code) {
		
		try{
			List<getReferenceByIdModel> getReferenceById = cobranzaFacade.getReferenceById(document, code);
			if(!GenericUtil.isCollectionEmpty(getReferenceById)) {
				return new ResponseEntity<List<getReferenceByIdModel>>(getReferenceById, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getReferenceByIdModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getReferenceByIdModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getManagerById/{document}/{code}")
	public ResponseEntity<List<getManagerByIdModel>> getManagerById(@PathVariable(value="document") String document,
			@PathVariable(value="code") String code) {
		
		try{
			List<getManagerByIdModel> getManagerById = cobranzaFacade.getManagerById(document, code);
			if(!GenericUtil.isCollectionEmpty(getManagerById)) {
				return new ResponseEntity<List<getManagerByIdModel>>(getManagerById, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getManagerByIdModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getManagerByIdModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getVoucherById/{document}/{code}")
	public ResponseEntity<List<getVoucherByIdModel>> getVoucherById(@PathVariable(value="document") String document,
			@PathVariable(value="code") String code) {
		
		try{
			List<getVoucherByIdModel> getVoucherById = cobranzaFacade.getVoucherById(document, code);
			if(!GenericUtil.isCollectionEmpty(getVoucherById)) {
				return new ResponseEntity<List<getVoucherByIdModel>>(getVoucherById, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getVoucherByIdModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getVoucherByIdModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getPayServiceDetail/{document}/{code}/{user}")
	public ResponseEntity<List<getPayServiceDetailModel>> getPayServiceDetail(@PathVariable(value="document") String document,
			@PathVariable(value="code") String code,@PathVariable(value="user") String user) {
		
		try{
			List<getPayServiceDetailModel> getPayServiceDetail = cobranzaFacade.getPayServiceDetail(document, code, user);
			if(!GenericUtil.isCollectionEmpty(getPayServiceDetail)) {
				return new ResponseEntity<List<getPayServiceDetailModel>>(getPayServiceDetail, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getPayServiceDetailModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getPayServiceDetailModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getListManger")
	public ResponseEntity<List<getListMangerModel>> getListManger() {
		
		try{
			List<getListMangerModel> getListManger = cobranzaFacade.getListManger();
			if(!GenericUtil.isCollectionEmpty(getListManger)) {
				return new ResponseEntity<List<getListMangerModel>>(getListManger, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListMangerModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListMangerModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getListVoucher")
	public ResponseEntity<List<getListVoucherModel>> getListVoucher() {
		
		try{
			List<getListVoucherModel> getListVoucher = cobranzaFacade.getListVoucher();
			if(!GenericUtil.isCollectionEmpty(getListVoucher)) {
				return new ResponseEntity<List<getListVoucherModel>>(getListVoucher, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListVoucherModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListVoucherModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getPayServiceDetailMonth/{document}/{code}/{user}")
	public ResponseEntity<List<getPayServiceDetailMonthModel>> getPayServiceDetailMonth(@PathVariable(value="document") String document,
			@PathVariable(value="code") String code,@PathVariable(value="user") String user) {
		
		try{
			List<getPayServiceDetailMonthModel> getPayServiceDetailMonth = cobranzaFacade.getPayServiceDetailMonth(document, code, user);
			if(!GenericUtil.isCollectionEmpty(getPayServiceDetailMonth)) {
				return new ResponseEntity<List<getPayServiceDetailMonthModel>>(getPayServiceDetailMonth, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getPayServiceDetailMonthModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getPayServiceDetailMonthModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getListPay/{user}/{explicite}")
	public ResponseEntity<List<getListPayModel>> getListPay(@PathVariable(value="user") String user,
			@PathVariable(value="explicite") String explicite) {
		
		try{
			List<getListPayModel> getListPay = cobranzaFacade.getListPay(user, explicite);
			if(!GenericUtil.isCollectionEmpty(getListPay)) {
				return new ResponseEntity<List<getListPayModel>>(getListPay, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListPayModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListPayModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getListlienteByManager/{manager}")
	public ResponseEntity<List<getListlienteByManagerModel>> getListlienteByManager(@PathVariable(value="manager") String manager) {
		
		try{
			List<getListlienteByManagerModel> getListVoucher = cobranzaFacade.getListlienteByManager(manager);
			if(!GenericUtil.isCollectionEmpty(getListVoucher)) {
				return new ResponseEntity<List<getListlienteByManagerModel>>(getListVoucher, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getListlienteByManagerModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getListlienteByManagerModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/getManagaerCount/{con}")
	public ResponseEntity<List<getManagaerCountModel>> getManagaerCount(@PathVariable(value="con") String con) {
		
		try{
			List<getManagaerCountModel> getManagaerCount = cobranzaFacade.getManagaerCount(con);
			if(!GenericUtil.isCollectionEmpty(getManagaerCount)) {
				return new ResponseEntity<List<getManagaerCountModel>>(getManagaerCount, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<getManagaerCountModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<getManagaerCountModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/patchManagerById/{document}/{code}/{code_manager}")
	public ResponseEntity<List<ResponseModel>> patchManagerById(@PathVariable(value="document") String document,
			@PathVariable(value="code") String code,@PathVariable(value="code_manager") Integer code_manager) {
		
		try{
			List<ResponseModel> patchManagerById = cobranzaFacade.patchManagerById(document, code, code_manager);
			if(!GenericUtil.isCollectionEmpty(patchManagerById)) {
				return new ResponseEntity<List<ResponseModel>>(patchManagerById, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/patchVoucherById/{document}/{code}/{voucher}/{service}")
	public ResponseEntity<List<ResponseModel>> patchVoucherById(
			@PathVariable(value="document") String document,
			@PathVariable(value="code") String code,
			@PathVariable(value="voucher") Integer voucher,
			@PathVariable(value="service") Integer service) {
		
		try{
			List<ResponseModel> patchVoucherById = cobranzaFacade.patchVoucherById(document, code, voucher, service);
			if(!GenericUtil.isCollectionEmpty(patchVoucherById)) {
				return new ResponseEntity<List<ResponseModel>>(patchVoucherById, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/putDirectionById/{document}/{code}/{number}/{zone}")
	public ResponseEntity<List<ResponseModel>> putDirectionById(
			@PathVariable(value="document") String document,
			@PathVariable(value="code") String code,
			@PathVariable(value="number") String number,
			@PathVariable(value="zone") Integer zone) {
		
		try{
			List<ResponseModel> putDirectionById = cobranzaFacade.putDirectionById(document, code, number, zone);
			if(!GenericUtil.isCollectionEmpty(putDirectionById)) {
				return new ResponseEntity<List<ResponseModel>>(putDirectionById, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/putPersonById/{document}/{name}/{last}/{second}/{client}")
	public ResponseEntity<List<ResponseModel>> putPersonById(
			@PathVariable(value="document") String document,
			@PathVariable(value="name") String name,
			@PathVariable(value="last") String last,
			@PathVariable(value="second") String second,
			@PathVariable(value="client") String client) {
		
		try{
			List<ResponseModel> putPersonById = cobranzaFacade.putPersonById(document, name, last, second, client);
			if(!GenericUtil.isCollectionEmpty(putPersonById)) {
				return new ResponseEntity<List<ResponseModel>>(putPersonById, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/putPersonById/{document}/{code}/{description}")
	public ResponseEntity<List<ResponseModel>> putReferenceById(
			@PathVariable(value="document") String document,
			@PathVariable(value="code") String code,
			@PathVariable(value="description") String description) {
		
		try{
			List<ResponseModel> putReferenceById = cobranzaFacade.putReferenceById(document, code, description);
			if(!GenericUtil.isCollectionEmpty(putReferenceById)) {
				return new ResponseEntity<List<ResponseModel>>(putReferenceById, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/deletePayService/{code}")
	public ResponseEntity<List<ResponseModel>> deletePayService(
			@PathVariable(value="code") String code) {
		
		try{
			List<ResponseModel> deletePayService = cobranzaFacade.deletePayService(code);
			if(!GenericUtil.isCollectionEmpty(deletePayService)) {
				return new ResponseEntity<List<ResponseModel>>(deletePayService, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/deleteDetailCount/{document}/{code}/{status}")
	public ResponseEntity<List<ResponseModel>> deleteDetailCount(
			@PathVariable(value="document") String document,
			@PathVariable(value="code") String code,
			@PathVariable(value="status") Integer status) {
		
		try{
			List<ResponseModel> deleteDetailCount = cobranzaFacade.deleteDetailCount(document, code, status);
			if(!GenericUtil.isCollectionEmpty(deleteDetailCount)) {
				return new ResponseEntity<List<ResponseModel>>(deleteDetailCount, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/postChangeAmount/{document}/{code}/{service}/{amount}/{dateformat}/{user}")
	public ResponseEntity<List<ResponseModel>> postChangeAmount(
			@PathVariable(value="document") String document,
			@PathVariable(value="code") String code,
			@PathVariable(value="service") Integer service,
			@PathVariable(value="amount") BigDecimal amount,
			@PathVariable(value="dateformat") Date dateformat,
			@PathVariable(value="user") Integer user) {
		
		try{
			List<ResponseModel> postChangeAmount = cobranzaFacade.postChangeAmount(document, code, service, amount, dateformat, user);
			if(!GenericUtil.isCollectionEmpty(postChangeAmount)) {
				return new ResponseEntity<List<ResponseModel>>(postChangeAmount, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping("/postPayService/{document}/{code}/{amount}/{user}/{manager}")
	public ResponseEntity<List<ResponseModel>> postPayService(
			@PathVariable(value="document") String document,
			@PathVariable(value="code") String code,
			@PathVariable(value="amount") BigDecimal amount,
			@PathVariable(value="user") Integer user,
			@PathVariable(value="manager") Integer manager) {
		
		try{
			List<ResponseModel> postPayService = cobranzaFacade.postPayService(document, code, amount, user, manager);
			if(!GenericUtil.isCollectionEmpty(postPayService)) {
				return new ResponseEntity<List<ResponseModel>>(postPayService, HttpStatus.OK);
			}
			else {
				return new ResponseEntity<List<ResponseModel>>(HttpStatus.NO_CONTENT);
			}
		}
		catch(Exception e) {	
			return new ResponseEntity<List<ResponseModel>>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@GetMapping(value = "/planilla", produces = MediaType.APPLICATION_PDF_VALUE)
	public ResponseEntity<InputStreamResource> planillaview() throws IOException {
		try {
			
			List<getListPayOneModel> diasDeudas = cobranzaFacade.getListPayOne();
				
				ByteArrayInputStream bis = PdfGenerator.pdfPayOne(diasDeudas);
				
				HttpHeaders headers = new HttpHeaders();
				headers.add("Content-Disposition", "inline; filename=planilla.pdf");
				
				return ResponseEntity.ok()
						.headers(headers)
						.contentType(MediaType.APPLICATION_PDF)
						.body(new InputStreamResource(bis));
		}
		catch(Exception e) {
				return new ResponseEntity<InputStreamResource>(HttpStatus.BAD_REQUEST);
		}
	}
	
}
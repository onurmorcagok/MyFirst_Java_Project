package com.services;

import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.dao.PersonDao;
import com.google.gson.Gson;
import com.model.Person;


@Path(value = "/service")
public class Service {
	/*
	 * // Database baglanti ayarlamasi (Hashmap tanimlamasi) private static
	 * Map<Integer, Person> persons = new HashMap<Integer, Person>();
	 * 
	 * // Baglanti verilen database verilerin eklenmesi static { for (int i = 0; i <
	 * 10; i++) { Person person = new Person(); int id = i + 1; person.setId(id);
	 * person.setFullName("Full Name: " + id); person.setAge(new
	 * Random().nextInt(40) + 1);
	 * 
	 * persons.put(id, person);
	 * 
	 * } }
	 */

	// Dao katmanindaki nesneyi Service classina import edip o classtaki ozellikleri kullandik
	
	private PersonDao personDao = new PersonDao();

	@GET
	@Path(value = "/getPersonById/{id}")
	@Produces("application/json")
	public Person getPersonById(@PathParam("id") int id) {
		return personDao.getPersonById(id);
	}
	
	
	@GET
	@Path(value = "/getAllPersonsInJSON" )
	@Produces("application/json")
	public String getAllPersonsInJSON() {
		
		List<Person> obj = personDao.getAllPersons();
		
		String json = new Gson().toJson(obj);
		
		return json;
	}
	
	@POST
	@Path (value = "/addPerson")
	@Produces (MediaType.APPLICATION_JSON)
	@Consumes (MediaType.APPLICATION_JSON)
	public String addPerson (String person) {
		
		Gson g = new Gson();
		Person p = g.fromJson(person, Person.class);
		System.out.println(p);
		
		if(!personDao.savePerson(p)) {
			return "{\"status\":\"ok\"}";
		}
		
		else {
			return "{\"status\":\"not ok\"}";
		}
		
	}
	
	@POST
	@Path (value = "/updatePerson")
	@Produces (MediaType.APPLICATION_JSON)
	@Consumes (MediaType.APPLICATION_JSON)
	public String updatePerson (String person) {
		
		Gson gson = new Gson();
		Person p = gson.fromJson(person, Person.class);
		System.out.println(p);
		
		
		if(!personDao.updatePerson(p)) {
			return "{\"status\":\"ok\"}";
		}
		
		else {
			return "{\"status\":\"not ok\"}";
		}
	}
	
	@POST
	@Path (value = "/deletePerson")
	@Produces (MediaType.APPLICATION_JSON)
	@Consumes (MediaType.APPLICATION_JSON)
	public String deletePerson(String person) {
		
		
		Gson gson = new Gson();
		Person p = gson.fromJson(person, Person.class);
		System.out.println(p);

		
		if(!personDao.deletePerson(p)) {
			return "Data remove...";
		}	
		else {
			return "Data not remove...";
		}
	}
}



//@POST
//@Path(value = "/add")
//@Produces("application/xml")
//@Consumes("application/json") 
//public Response createTrackInJSON(UserModel userModel) {
//	 
//	return Response.status(200).entity(userModel).build();
//}
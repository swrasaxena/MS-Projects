package model;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.persistence.*;

import study.Study;

public class PersonDao {
	
	private static final String PERSISTENCE_UNIT_NAME = "ws1";
	private static EntityManagerFactory factory = Persistence.createEntityManagerFactory(PERSISTENCE_UNIT_NAME);
	

	public List<Person> load() {
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();

		List<Person> person = (List<Person>)em.createNamedQuery("Person.findAll", Person.class).getResultList();
		Query query4 = em.createNativeQuery("select grp.group_name, grp.group_id from groups grp, group_person gp, person p"
				+ " where grp.group_id = gp.group_id and gp.person_id = p.person_id and user_name =?1");
		
		List<Object[]> obj1 =(List<Object[]>) query4.setParameter(1, "avanti").getResultList();
		for (Object[] objs: obj1){
			System.out.println("Group Name is" + objs[0] + " Group id is"+ objs[1]);
		}
			
		// Aniket comment query 
		Query  query =em.createNativeQuery
             	( "select id, post, p.person_id, group_id, first_name from post p, person per where p.group_id=?1 "
             			+ "and p.person_id = per.person_id");
		
		
	
	    
		Map<Object[], List<Object[]>> map = new HashMap<Object[], List<Object[]>>();
		
	    List<Object[]> obj = (List<Object[]>) query.setParameter(1, 1).getResultList();
	    for (Object[] objs : obj){
	    	System.out.println("id is" + objs[0] + "Post is"+ objs[1] + "Person id of post is" + objs[2]);
	    	System.out.println("Post Name is " + objs[4]);
	    	//Query query2 = em.createNativeQuery("select c.comment, c.person_id from comment c where c.p_id= " + objs[0]);
	    	Query query2 = em.createNativeQuery("select c.comment, c.id, c.person_id, p.first_name from comment c, person p where c.person_id = p.person_id and c.p_id =" + objs[0]);
	    	List<Object[]> obj2 = (List<Object[]>) query2.getResultList();
	    	map.put(objs, obj2);
	    	for (Object[] objs1 : obj2){
	    		System.out.println("Comments are " + objs1[0] + "Person id is" + objs1[1]);
	    		//Query cmt_person = em.createNativeQuery("select first_name from person where person_id= " + objs1[1]);
	    		//String cmt_name= (String) cmt_person.getSingleResult();
	    		System.out.println(" Cmnt Name is" + objs1[3]);
	    		
	    		
		
		
		
		
		// *88888888888888888888888888888888888888888888888888888888
		/*Query  query =em.createNativeQuery
             	( "select id, post,person_id from post where group_id= ?1");
		
		//Map<String, Object> map = new HashMap<String, Object>();
		//List<Map> list = new ArrayList<Map>();
	   // Map<String, Object> map_comments = new HashMap<String, Object>();
	    
	    List<Object[]> obj = (List<Object[]>) query.setParameter(1, 1).getResultList();
	    for (Object[] objs : obj){
	    	System.out.println("id is" + objs[0] + "Post is"+ objs[1] + "Person id of post is" + objs[2]);
	    	Query query_person = em.createNativeQuery("select first_name from person where person_id= " + objs[2]);
	    	String name= (String)query_person.getSingleResult();
	    	System.out.println("Post Name is " + name);
	    	Query query2 = em.createNativeQuery("select c.comment, c.person_id from comment c where c.p_id= " + objs[0]);
	    	List<Object[]> obj2 = (List<Object[]>) query2.getResultList();
	    	for (Object[] objs1 : obj2){
	    		System.out.println("Comments are " + objs1[0] + "Person id is" + objs1[1]);
	    		Query cmt_person = em.createNativeQuery("select first_name from person where person_id= " + objs1[1]);
	    		String cmt_name= (String) cmt_person.getSingleResult();
	    		System.out.println(" Cmnt Name is" + cmt_name);
	    	}
	    	}
	    	
	    
	    // Aniket -> Insert query
	    Group group = em.find(Group.class, 1);
	    System.out.println("Group is" + group);
	    if(group != null){
	    Post p = new Post();
	    p.setGroup(group);
	    p.setPost("Wateva!!");
	    em.persist(p);
	    System.out.println("Post is " + p);}
	    else {
	    	System.out.println("Group not found");
	    }
	    
	    // Swara -> Role query
	   
		Query roleQry = em.createNativeQuery("select role_name from person where user_name= ?1");
		String role =   (String) roleQry.setParameter(1, "Avanti").getSingleResult();
		System.out.println("Role of Avanti is" + role);
		
		// Swara -> User & Pwd query 
		/* Query query1 = em.createNativeQuery("select user_name from person where user_name= ?1");
		System.out.println (query1.setParameter(1, "Rohan"));
		//String user_name = (String)query1.setParameter(1, "Rohan").getSingleResult();
		System.out.println();
		if( user_name != null){
		System.out.println("User is " + user_name);
		}
		else
			{System.out.println("USer not found");} */
		Query query12 = em.createNativeQuery("select person_id,password from person where user_name=?1");
		try{
		Object id[] = new Object[2];
				id = (Object[])query12.setParameter(1, "raj").getSingleResult();
		
		int personid= (int) id[0];
		String pwd = (String) id[1];
		
		System.out.println("personid is " + personid);
		System.out.println("Pwd is " + pwd);
		if (pwd.equals("xyz"))
		{
			System.out.println("Password matches");
		}
		}
		catch(NoResultException e)
		{
			System.out.println("Result not found");
		}
		
		
		
		/*Query  query3 =em.createNativeQuery
             	("select user_name from person");
		List<String> userName1 = (List <String>) query3.getResultList();
	    for (String name : userName1){
	    	try {
	    		Query query2 = em.createNativeQuery("select user_name from person where user_name=?1");
	    	    String userName= (String)query2.setParameter(1, "avanti").getSingleResult();
	        	if (name.equalsIgnoreCase(userName))
		    	{
		    		System.out.println("User name matches");
		    
		    	} 
	    	} catch (NoResultException e) {
	           System.out.println("User not found");
	    		
	    	} */
	    	
	    	//String user_name =   (String) query2.setParameter(1, "Avanti").getSingleResult();
	    	//System.out.println("USername is " + query2.toString())
	
	    	
		
	 
		//p.setUserName("avanti");
		//p.setPassword("xyz");
		//em.persist(p);
		//System.out.println("Person is mee" + p);
		/* Query  query =em.createNativeQuery
             	( "select id, post from post where group_id= ?1");
	    List<Object[]> obj = (List<Object[]>) query.setParameter(1, 2).getResultList();
	    for (Object[] objs : obj)
	    	System.out.println("Objects is" + objs[0] + " "+ objs[1]); */
		
	} }
	  em.getTransaction().commit();
		em.close();
	    return person;}
	/*public  registerUser(String usr, String pwd) {
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();


	   
	} */

	
	public List<Person> get() {
		EntityManager em = factory.createEntityManager();
		em.getTransaction().begin();

		Query  query =em.createNativeQuery
             	( "select id, post from post where group_id= ?1");
	    List<Object[]> obj = (List<Object[]>) query.setParameter(1, 2).getResultList();
	    for (Object[] objs : obj){
	    	System.out.println("Objects is" + objs[0] + " "+ objs[1]);
	    	Query query2 = em.createNativeQuery("select comment from comment where p_id= " + objs[0]);
	    	List<String> comments = (List<String>) query.getResultList();
	    	for (String comment : comments){
	    		System.out.println("Comments are" + comment);
	    	}
	    	

	    }
   
	
/*		for (Object objs : obj){
			Object value =  (Object)objs;
			int id= (Integer) value[0];
			String post= (String) value[1];
			System.out.println("Post is" + post);
			Query  query2 =em.createNativeQuery
                 	( "select comment from comment where p_id='"+ rs.getInt("id") + "'";");
			
			
		} */
		List<Person> person = (List<Person>)em.createNamedQuery("Person.findAll", Person.class).getResultList();
		
		em.getTransaction().commit();
		em.close();
		return person;
	}
	
	
	public static void main(String[] args) {
		Person person = new Person();
        PersonDao dao = new PersonDao();
		List<Person> persons = dao.load();
		System.out.println("Person");
		for(Person p: persons)
			System.out.println(p);
	}
}
